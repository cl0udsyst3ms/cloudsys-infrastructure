module "rds" {
  source = "modules/rds"

  db_subnet_id  = "${module.network.db_subnet_id}"
  vpc_id        = "${module.network.vpc_id}"
}
