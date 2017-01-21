module "ecs" {
  source = "modules/ecs"

  dmz_subnet_id  = "${module.network.dmz_subnet_id}"
  app_subnet_id  = "${module.network.app_subnet_id}"
  vpc_id         = "${module.network.vpc_id}"
}
