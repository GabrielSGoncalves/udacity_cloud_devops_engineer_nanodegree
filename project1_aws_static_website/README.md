# Project 1 - Deploy Static Website on AWS

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
