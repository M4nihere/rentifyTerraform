# Elastic Beanstalk Application
resource "aws_elastic_beanstalk_application" "rentifyJava" {
  name = "rentifyJava"
  tags = {
    Name = "rentifyJava"
  }
}

# Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "RentifyJava-env" {
  name                = "RentifyJava-env"
  application         = aws_elastic_beanstalk_application.rentifyJava.name
  solution_stack_name = "64bit Amazon Linux 2 v3.7.0 running Corretto 17"  # Choose your desired platform
  # Add other configuration options as needed
  tier                = WebServer

}

# CodePipeline
resource "aws_codepipeline" "my_pipeline" {
  name     = "my-codepipeline"
  role_arn = "arn:aws:iam::123456789012:role/service-role/AWSCodePipelineServiceRole-us-east-1"

  artifact_store {
    location = "my-bucket-name"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = "my-repository"
        BranchName     = "main"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ElasticBeanstalk"
      input_artifacts = ["source_output"]
      version         = "1"

      configuration = {
        ApplicationName  = aws_elastic_beanstalk_application.my_application.name
        EnvironmentName  = aws_elastic_beanstalk_environment.my_environment.name
        VersionLabel     = "v1"  # Version label of your application
        # Add other configuration options as needed
      }
    }
  }
}
