#!/bin/bash -eux

# Install aws cli on the AMI

sudo curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt-get update
sudo apt-get install unzip -y
sudo unzip awscliv2.zip
sudo ./aws/install