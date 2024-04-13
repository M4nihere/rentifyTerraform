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
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = module.vpc.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = module.vpc.Private_subnet1
  }
    setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = module.vpc.Private_subnet2
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

    setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.rentify.key_name
  }
    setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }
    setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
  }
    setting {
    namespace = "aws:ec2:instances"
    name      = "SupportedArchitectures"
    value     = "x86_64"
  }
    setting {
    namespace = "aws:cloudformation:template:parameter"
    name      = "EnvironmentVariables"
    value     = "PORT=8080,M2=/usr/local/apache-maven/bin,M2_HOME=/usr/local/apache-maven,GRADLE_HOME=/usr/local/gradle"
  }
}
