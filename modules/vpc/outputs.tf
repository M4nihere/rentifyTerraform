output "vpc_id" {
  value = aws_vpc.main.id
}


output "instance_profile_name" {
  value = aws_iam_instance_profile.beanstalk_instance_profile.name
}

output "Private_subnet1" {
  value = aws_subnet.Beanstalk-Private-Subnet1.id
}


output "Private_subnet2" {
  value = aws_subnet.Beanstalk-Private-Subnet2.id
}

