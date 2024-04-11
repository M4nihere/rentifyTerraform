# EC2 Key Pair for Beanstalk EC2 Instances
resource "aws_key_pair" "beanstalk-key" {
  key_name   = "beanstalk-key"            # Name for your key pair
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key file
}


#