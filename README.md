# Bridge2Work

# Bridge2Work – ShopEdge Deployment

Bridge2Work/

  ├── Dockerfile
  
  ├── README.md
  
  ├── app/
  
  │    └── main.py
  
  ├── k8s/
  
  │    ├── deployment.yaml
  
  │    └── service.yaml
  
  ├── terraform/
  
  │    ├── main.tf
  
  │    └── variables.t
  
  ├── .github/
  
  │    └── workflows/
  
  │         └── ci-cd.ym


1. Infrastructure (Terraform)
I used Terraform to define all the cloud resources needed for this project. This approach makes the entire infrastructure versionable and repeatable. You can see the full code in the terraform/ directory.

Here's what I set up:

VPC and Networking: A dedicated private network (10.0.0.0/16) with two subnets spread across two different Availability Zones (us-east-1a and us-east-1b) for high availability. An Internet Gateway provides public access.

Security: I created specific Security Groups to act as firewalls for each type of resource. For example, the web servers can talk to the databases, but the databases are not open to the public internet.

Compute: I provisioned two EC2 Instances (virtual machines) to act as general-purpose servers, one in each subnet.

Database: For data storage, I created two RDS (MySQL) database instances, also one in each subnet.

Container Orchestration: For a scalable application environment, I provisioned two EKS Clusters (Kubernetes), one in each subnet. This is where our application will run.

2. CI/CD (GitHub Actions)
I built a simple but effective CI/CD pipeline using GitHub Actions. This workflow automatically builds and deploys the application every time code is pushed to the main branch.

The pipeline performs three key steps:

Build: It takes the application code from app/ and the Dockerfile to build a new Docker image.

Push: It logs into Docker Hub using credentials stored securely in GitHub Secrets and pushes the newly created image.

Deploy: It connects to the EKS cluster and applies the Kubernetes manifest files from the k8s/ directory to deploy the application. Each deployment is tagged with the unique Git commit SHA, so we always know exactly which version is running.

3. Application (FastAPI)
The application itself is a very simple web service built with FastAPI. It just returns a friendly "Hello from ShopEdge App" message. The purpose of this app is to serve as a practical example to demonstrate the Dockerization and Kubernetes deployment process.

How to Run Locally
If you'd like to test the application on your own machine, you can easily build and run the Docker image.

Build the Docker image:

Bash

docker build -t shopedge-app .
Run the container on your local machine:

Bash

docker run -p 80:80 shopedge-app
Open your web browser and navigate to http://localhost. You should see the welcome message!
