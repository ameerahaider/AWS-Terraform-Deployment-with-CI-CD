# AWS Terraform Deployment with CI/CD

This repository provides Terraform scripts designed to deploy a basic Python application on AWS, complemented by an automated CI/CD pipeline for building and deploying the app.

## Infrastructure Overview

### **1. VPC Module** (`./modules/vpc/main.tf`)
- Creates a VPC with defined CIDR blocks.
- Sets up public subnets, private subnets, and a database subnet.
- Configures an Internet Gateway and NAT Gateway.

### **2. Security Groups Module** (`./modules/sg/main.tf`)
- Establishes distinct security groups to control inbound and outbound traffic for various resources.

### **3. Servers Module** (`./modules/servers/main.tf`)
- Provisions EC2 instances.
- Contains user data scripts for database setup.

### **4. Autoscaling Group Module** (`./modules/autoscaling_group/main.tf`)
- Defines an Auto Scaling Group for application instances.
- Configures a launch template.

### **5. ALB Module** (`./modules/alb/main.tf`)
- Creates an Application Load Balancer (ALB).
- Configures a target group for traffic routing.

## Python Application Deployment

The application in focus is a simple Python web app, which will be containerized using Docker and stored in Amazon Elastic Container Registry (ECR).

## CI/CD Pipeline

The CI/CD pipeline is pivotal in automating the app deployment process. Let's delve into the specific stages:

1. **Build Stage**: 
- Authenticates with AWS and logs into the ECR repository.
- Constructs a Docker image of the Python app.
- Pushes the Docker image to the ECR repository.

2. **Deploy Stage**:
- Sets up required CLI tools and authenticates with AWS.
- Uses Terraform to derive necessary outputs, such as EC2 IPs.
- Connects to the jump server, which then SSHs into private EC2 instances.
- Pulls the Docker image from the ECR repository onto the EC2 instances.
- Deploys and runs the Docker container on the instances.

**Note**: The CI/CD pipeline script uses AWS Identity and Access Management (IAM) for permissions, roles, and secure tokens to ensure a secure deployment process.

## Variables Configuration

Customization is paramount. Modify the `Variables.tfvar` file to tweak the deployment as per your specifications. This includes altering the CIDR block, specifying the desired subnets, choosing an AMI ID, and selecting a key pair, among other settings.

## Deployment Instructions

1. Make sure Terraform is installed on your machine.
2. Configure `Variables.tfvar` as per your specifications.
3. Run the commands in the project's root directory:
   
  ```bash
    terraform init
    terraform plan
    terraform apply
  ```

Upon completion, the terminal will display pertinent outputs, such as the ALB DNS name and the public IP of the jump server.

**Destruction**:
To tear down the infrastructure:

  ```bash
    terraform destory
  ```

## Caution

Always exercise prudence when deploying or deleting the infrastructure. Ensure you review the variables and changes meticulously before applying them, as these operations can lead to resource creation or deletion on AWS.

## Conclusion

With this repository, you have an efficient system to seamlessly deploy a Python application on AWS with high reliability, scalability, and automation. Always keep security practices at the forefront, and happy deploying!
