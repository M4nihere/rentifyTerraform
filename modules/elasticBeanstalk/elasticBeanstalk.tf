module "vpc" {
  # Module arguments go here (if any)
  source = "../../modules/vpc"
}
# Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "Java-dev-Node" {
  name = "Java-dev-Node"
  tags = {
    Name = "Java-dev-Node"
  }
}

# Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "Java-dev-Node-env" {
  name                = "Java-dev-Node-env"
  application         = aws_elastic_beanstalk_application.Java-dev-Node.name
  solution_stack_name = "64bit Amazon Linux 2 v3.7.0 running Corretto 17"  # Choose your desired platform
  # Add other configuration options as needed
  tier                = "WebServer"


  depends_on = [
    aws_iam_role.beanstalk_role,
    aws_iam_role.aws-elasticbeanstalk-ec2-role
  ]
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = aws_subnet.Beanstalk-Private-Subnet2.id
  }
    setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = aws_subnet.Beanstalk-Private-Subnet1.id
  }
  
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "arn:aws:iam::533267151730:role/service-role/aws-elasticbeanstalk-service-role"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = module.vpc.instance_profile_name
  }
}
