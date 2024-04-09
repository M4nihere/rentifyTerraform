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
    value     = "module.vpc.aws_vpc.main.id"
  }
    setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "module.vpc.aws_subnet.Beanstalk-Private-Subnet1.id"
     #value     = "aws_subnet.Beanstalk-Private-Subnet2.id"
  }

}


