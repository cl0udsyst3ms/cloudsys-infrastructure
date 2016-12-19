module "core" {
  source = "modules/compute/core"

  dmz_subnet_id  = "${module.network.dmz_subnet_id}"
  vpc_id         = "${module.network.vpc_id}"
}

module "nodes" {
  source = "modules/compute/nodes"

  app_subnet_id  = "${module.network.app_subnet_id}"
  vpc_id         = "${module.network.vpc_id}"
}

module "ecs" {
  source = "modules/compute/ecs"

  app_subnet_id  = "${module.network.app_subnet_id}"
  app2_subnet_id = "${module.network.app2_subnet_id}"
  vpc_id         = "${module.network.vpc_id}"
}
