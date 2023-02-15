#!/bin/bash

#update the environment

sudo yum update -y

# Install the AWS CLI if not already installed
if ! command -v aws &> /dev/null
then
    echo "AWS CLI not found. Installing..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    echo "AWS CLI installed."
fi

# Download the latest version of the application code from S3
aws s3 cp s3://sailpoint-iiq/identityiq+2.war /tmp/identityiq.zip

# https://sailpoint-iiq.s3-us-gov-west-1.amazonaws.com/identityiq+2.war

# Unzip the application code
unzip -o /tmp/identityiq.zip -d /var/app/current

# Restart the application server
sudo systemctl restart my-app.service

echo "Deployment complete."
