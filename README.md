# devops-qr-code

This is the sample application for the DevOps Capstone Project.
It generates QR Codes for the provided URL, the front-end is in NextJS and the API is written in Python using FastAPI.

## Application

**Front-End** - A web application where users can submit URLs.

**API**: API that receives URLs and generates QR codes. The API stores the QR codes in cloud storage(AWS S3 Bucket).


##  Progress

Made the Dockerfile and ran it locally.

Uploaded the image to ECR Repo.

Deployed the code to github and made github cicd pipeline code and it runs successfully.

Deployed on ECS and ran it, only remaing thing exposing them using load balancer and using route 53 to route them to a domain.

## Remaining

Making IaC code for the EKS Cluster and deploying it via Terraform CI CD

Deploying the images on EKS Cluster.

# Devops
# Devops
# Devops
# InfranDevOps
