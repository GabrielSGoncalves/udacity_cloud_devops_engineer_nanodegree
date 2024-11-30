# Project 1 - Deploy Static Website on AWS
## Overview
Hosting websites is one of the most basic tasks related to cloud infrastructure. For static websites, composed basically of HTML, CSS and JavasScript files (no backend), AWS offers a simple way of hosting it using S3. CloudFront is a content delivery service that can also help lowering the latency for users from different regions. We are going to explore these two AWS services in a static website deploy.

## Objective
1. Creating the cloud infrastructure using S3

## Creating a AWS service user for using with Terraform

## Configuring the AWS CLI
With the service user created and AWS access and secret keys, I configured a new profile on AWS CLI in order to interact with my AWS account programatically. I named the profile as `udacity`, to differentiate from the `default`, from my personal AWS account.
```bash
aws configure --profile udacity
```

I added the respective access key, secret key and region, as required from the terminal.

With the AWS CLI configured, I have access to all services with granted access for the service user. For instance, I can verify my AWS project account provided by Udacity with the following command:
```bash 
aws sts get-caller-identity --query Account --output text --profile udacity
```

## Creating AWS resources with Terraform
In order to have control over the cloud infrastructure created for the project, I'll be using Terraform as the Insfrastructure as Code (IaC) framework.

-> Describe step by step on how to install and configure Terraform

## Creating the S3 bucket
To create the S3 bucket I can use the Terraform resource block bellow:


```text title="main.tf"
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-855655753923-bucket"

  tags = {
    project = "s3 static website"
  }
}
```

```tf title="main.tf"
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-855655753923-bucket"

  tags = {
    project = "s3 static website"
  }
}
```

## Making the S3 bucket publicly accessible
Next step consists in allow public access to the S3 bucket. Again we leveraged the 

## Uploading files to S3
The project description required that I used the provided files for static website:
[udacity-starter-website.zip](https://drive.google.com/file/d/15vQ7-utH7wBJzdAX3eDmO9ls35J5_sEQ/view)
After downloading it to my local Github project repository, I have extracted the folder and uploaded it to my S3 bucket usign AWS CLI:
```bash
unzip udacity-starter-website.zip -d udacity-starter-website
cd udacity-starter-website
aws s3 sync . s3://my-855655753923-bucket --profile udacity
```

The uploaded took a few minutes, as there are a few thousand small files on the extracted folder. The picture bellow illustrates the S3 after the upload.
![S3 after upload](images/s3_with_uploaded_files.png)
