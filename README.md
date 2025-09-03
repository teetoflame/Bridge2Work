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
Used Terraform to define the cloud infrastructure environments for ShopEdge:
VPC (10.0.0.0/16): The private network for all resources.
2 Subnets (us-east-1a & us-east-1b): To distribute resources across availability zones.
Internet Gateway + Routing: Enables public access for compute resources.
EC2 Instances: Two virtual machines (one in each subnet) for hosting applications.
RDS Instances: Two MySQL databases (one in each subnet) for persistent storage.
EKS Clusters: Two Kubernetes clusters (each spanning both subnets) for containerized workloads.
Security Groups: Control access—SSH/HTTP for EC2, restricted DB access for RDS, and dedicated SGs for EKS.
This ensures a scalable, multi-AZ architecture with networking, compute, databases, and container orchestration fully defined as code.

2. Application (FastAPI)
Built a lightweight FastAPI web application to demonstrate deployment. The app simply displays a welcome message — “Hello from ShopEdge App”. It was containerized with Docker for portability and deployed to Kubernetes (EKS) for scalability and orchestration.

3. CI/CD (GitHub Actions)
Implemented a GitHub Actions workflow to automate the application lifecycle:
Trigger – Runs whenever code is pushed to the main branch.
Build – Builds a Docker image from the FastAPI application source.
Push – Authenticates to Docker Hub using GitHub Secrets and pushes the image.
Deploy – Applies the Kubernetes manifest files (deployment.yaml, service.yaml) to the EKS cluster using kubectl.
Versioning – The Docker image tag is automatically updated with the Git commit SHA, ensuring each build is uniquely identifiable.
Secrets Management – Sensitive data (Docker credentials, Kubernetes config) is stored securely in GitHub Secrets, never exposed in code
## 4. How to Run Locally
```bash
docker build -t shopedge-app .
docker run -p 80:80 shopedge-app
# Bridge2Work
