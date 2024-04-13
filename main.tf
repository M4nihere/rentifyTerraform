module "vpc" {
  # Module arguments go here (if any)
  source = "./modules/vpc"
}

module "elasticbeanstalk" {
  # Module arguments go here (if any)
  source = "./modules/elasticBeanstalk"
  depends_on = [module.vpc]
}
