module "RG" {
  source      = "./modules/rg"
  RG_Name     = var.RG_Name
  RG_Location = var.RG_Location
}

module "Network" {
  source      = "./modules/network"
  RG_Name     = module.RG.RG_Name
  RG_Location = module.RG.RG_Location
  VNET_Name   = var.VNET_Name
  depends_on  = [module.RG]
}

module "LoadBalancer" {
  source      = "./modules/loadbalancer"
  RG_Name     = module.RG.RG_Name
  RG_Location = module.RG.RG_Location
  depends_on  = [module.Network]
}

module "VMSS" {
  source                     = "./modules/vmss"
  RG_Name                    = module.RG.RG_Name
  RG_Location                = module.RG.RG_Location
  subnet_id                  = module.Network.subnet_id
  lb_backend_address_pool_id = module.LoadBalancer.lb_backend_address_pool_id
  VNET_Name                  = module.Network.VNet_Name
  lb_probe_id                = module.LoadBalancer.lb_probe_id
  depends_on                 = [module.Network, module.LoadBalancer]
}

