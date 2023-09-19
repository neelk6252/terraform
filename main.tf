provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "alb-sg" {
  source = "./modules/alb-sg"
  vpcid  = module.vpc.vpc_id

}
module "EC2-sg" {
  source = "./modules/ec2-sg"
  vpcid  = module.vpc.vpc_id
}

module "iam_role" {
  source = "./modules/iam_role"
}

module "alb" {
  source = "./modules/alb"
  depends_on = [
    module.alb-sg
  ]
  subnetsids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id
  security-groups = module.alb-sg.ALB_cloud_clan_sg

}