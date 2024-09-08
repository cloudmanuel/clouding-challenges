# Clouding Challenge

I have created a couple of common scenarios that I have come accross during my time as a cloud engineer. These are just some simple troubleshooting task that will help you gain a better undertsanding of how small details can cause headaches but also show that documentation is important. 

Please remember: Creating the resources in any challege can occur a fee or charge, so please clean up all resources once complete. 

The solution for every challenge/problem will be in the README file of each directory. 

I highly recommend using no resources when attempting the challenge the first time, if you really need assistance and are stuck I suggest maybe seeing if logging is enabled for the resources or terraform, if not seeing if you can enable it (via code preferably) and if that doesnt assit, then look into aws documents of the problem you are facing.

If that doesnt help, then you can use google and other resources. Yes, I understand that in the real world google will be easily accessible along with stack overflow and the rest of the internet, but if you are early on in your career, the more important part of this challenge is beginning to understand the steps to troubleshoot issues and the "how" things happen and work together. Getting a solution without understanding why it was causing a problem will not get you very far the next time you run into a simliar situation. 

## Getting Started

There are multiple ways of creating the resources if you want to do so. In this repo, there is a github workflow and a terraform.yml file. 

### Steps to use github actions to deploy resources:

1) Create an s3 bucket outside of terraform (manually) to store your remote state in.

2) Create an AWS IAM user with proper permissions needed to create the resources in each challenge, then grab that users credentials and add them as github secrets for AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.

3) Modify the terraform.yml and the work directory to match the challenge you want the github actions to deploy.

4) Modify the terraform init line in terraform.yml.

5) Modify the main.tf file in the directory and uncomment the backend line in the terraform block.

6) Push your changes to your github repo and check to see if the GHA runs. 

*Clean it all up after, DO NOT paste your access keys into repos*

Close example minus the TF organization steps (https://developer.hashicorp.com/terraform/tutorials/automation/github-actions)

### Running terraform locally:

You will need to either paste credentials into your terminal, configure credentials in aws config file, or in a terraform provider block.

``` provider “aws” {
  region = “us-east-1”
  access_key = “A****************”
  secret_key =   “U**************”
} 
```

When running things locally, again make sure to not upload the files with credentials anywhere. 

Optionally, if you want to use s3 remote file for this even when running locally, you would uncomment the s3 line in the main.tf like in the example above. Example:

terraform {
    backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
  required_version = ">= 1.6.6"
  required_providers {
    aws = {
      version = ">= 5.34.0"
      source  = "hashicorp/aws"
    }
  }
}

1) Change directory to the challenge you are working on.

2) Open a terminal. Run terraform init, if it cant find your configurations it might ask you for them.

3) Run terraform plan. It should output the resources it plans to create, review them and make sure they seem to be what is expected.

4) Run terraform apply, and confirm the apply.

*Clean it all up after, DO NOT paste your access keys into repos*

Close example (https://developer.hashicorp.com/terraform/cloud-docs/run/cli)