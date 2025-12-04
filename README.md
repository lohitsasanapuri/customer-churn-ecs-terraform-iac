# Customer Churn FastAPI – AWS ECS (Fargate) Deployment with Terraform

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?logo=amazonaws)
![FastAPI](https://img.shields.io/badge/FastAPI-Backend-009688?logo=fastapi)

A **production-style infrastructure project** that deploys a **Customer Churn Prediction API** on **AWS ECS (Fargate)** using **Terraform** with **remote state in S3** and **manual CI/CD via GitHub Actions**.

This repo focuses on **real-world DevOps patterns**: containerized ML inference, load-balanced access, IAM least privilege, immutable infrastructure, and state persistence across local and CI runs.

---

## 🚀 Tech Stack

* **Backend**: FastAPI + Gradio
* **Containerization**: Docker
* **Cloud**: AWS
* **Compute**: ECS (Fargate)
* **Networking**: VPC, Subnets, Internet Gateway
* **Load Balancer**: Application Load Balancer (ALB)
* **Logging**: CloudWatch Logs
* **IaC**: Terraform
* **State**: Amazon S3 (Remote Backend)
* **CI/CD**: GitHub Actions (workflow_dispatch)

---

## 🏗 Architecture Overview

* Custom **VPC** with public subnets (multi-AZ)
* **Internet Gateway** for external access
* **ALB (HTTP :80)** routing traffic to ECS
* **Target Group (port 8000)** for FastAPI
* **ECS Cluster + Service (Fargate)**
* **IAM Execution Role** (least privilege)
* **CloudWatch Logs** for container output
* **Terraform State persisted in S3**

---

## 🧩 Architecture Diagram

![AWS ECS FastAPI Architecture](assets/architecture_diagram.png)

**Highlights**

* Users access the service via an **internet-facing ALB**
* ALB forwards requests to an **ECS Target Group**
* **FastAPI + Gradio** run as **Fargate tasks**
* Infrastructure spans **multiple AZs** for resiliency
* Terraform state is **decoupled from runners and stored in S3**

---

## 📁 Project Structure

```
custmer_churn_ml_end_to_end_iac/
├── alb.tf                # ALB, listener, target group
├── backend.tf            # S3 backend configuration
├── ecs.tf                # ECS cluster, task definition, service
├── iam.tf                # IAM roles and policies
├── provider.tf           # AWS provider
├── security.tf           # Security groups
├── vpc.tf                # VPC, subnets, IGW, routes
├── variables.tf          # Inputs
├── outputs.tf            # Outputs (ALB DNS)
├── .gitignore
└── README.md
```

---

## 🐳 Docker Image

```
lohitsasanapuri/telco-fastapi:latest
```

FastAPI listens on **port 8000**.

---

## ⚙️ Prerequisites

* AWS account
* AWS CLI configured
* Terraform v1.5+
* Docker image pushed to Docker Hub

---

## 🛠 One-Time Setup (Remote State)

Terraform **cannot create its own backend**. Create the S3 bucket **once** before running Terraform:

```bash
aws s3 mb s3://customer-churn-terraform-state --region us-east-1
```

---

## 🚀 Deploy Infrastructure

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

Open the **ALB DNS name** from outputs in your browser.

---

## 🌐 Application Endpoints

* **Health Check**

  ```http
  GET /
  ```
* **Prediction API**

  ```http
  POST /predict
  ```
* **Gradio UI**

  ```
  /ui
  ```

---

## 🔁 CI/CD – GitHub Actions

The workflow supports **manual apply & destroy** using `workflow_dispatch`.

**Steps**

1. Go to **Actions → Terraform Deploy / Destroy**
2. Click **Run workflow**
3. Choose:

   * `apply` → create/update infrastructure
   * `destroy` → tear everything down

**Required Secrets**

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`

(State is shared via S3, so CI and local runs stay in sync.)

---

## 🧨 Destroy Infrastructure

```bash
terraform destroy -auto-approve
```

Works whether the stack was created locally or from GitHub Actions.

---

## 📝 Important Notes

* Do **not** manage the S3 backend bucket inside Terraform
* Remote state avoids lost infrastructure in CI
* Fargate removes all EC2 management
* Logs available in CloudWatch

✅ Fully reproducible, CI-safe, and production-aligned infrastructure
