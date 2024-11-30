# Project 1 - Deploy Static Website on AWS
## Overview
Hosting websites is one of the most basic tasks related to cloud infrastructure. For static websites, composed basically of HTML, CSS and JavasScript files (no backend), AWS offers a simple way of hosting it using S3. CloudFront is a content delivery service that can also help lowering the latency for users from different regions. We are going to explore these two AWS services in a static website deploy.

## Objective


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

