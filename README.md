# Task Manager API — DevOps Portfolio Project

A production-grade REST API deployed on AWS using modern DevOps practices including Infrastructure as Code, CI/CD automation, containerization, and cloud monitoring.

---

## Architecture Overview

Developer → GitHub → GitHub Actions CI/CD → AWS EC2
                                          → AWS RDS PostgreSQL
                                          → AWS S3
                                          → AWS CloudWatch

The project follows a two-phase deployment model:
- Phase 1 — Infrastructure: Terraform provisions all AWS resources
- Phase 2 — Deployment: GitHub Actions automatically builds and deploys on every git push

---

## Technology Stack

| Category | Technology |
|---|---|
| Application | Python 3.11, FastAPI |
| Containerization | Docker |
| Infrastructure as Code | Terraform |
| CI/CD Pipeline | GitHub Actions |
| Cloud Provider | AWS (Free Tier) |
| App Server | AWS EC2 t3.micro |
| Database | AWS RDS PostgreSQL |
| File Storage | AWS S3 |
| Monitoring | AWS CloudWatch |
| Source Control | Git + GitHub |

---

## Features

- REST API with full CRUD operations for task management
- Automated CI/CD — every push to main triggers tests and deployment
- Infrastructure as Code — entire AWS infrastructure defined in Terraform
- Containerized — Docker ensures consistent environments
- Monitored — CloudWatch dashboards, logs, and CPU alerts
- Tested — automated pytest suite runs on every pull request

---

## API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| GET | /health | Health check |
| GET | /tasks | Get all tasks |
| POST | /tasks | Create a new task |
| PUT | /tasks/{id} | Update task status |
| DELETE | /tasks/{id} | Delete a task |

Interactive API documentation available at /docs when running.

---

## Project Structure

task-manager-devops/
├── app/
│   ├── main.py              # FastAPI application
│   ├── models.py            # SQLAlchemy database models
│   ├── database.py          # Database connection
│   ├── requirements.txt     # Python dependencies
│   └── tests/
│       └── test_main.py     # Pytest test suite
├── terraform/
│   ├── main.tf              # AWS infrastructure definition
│   ├── variables.tf         # Input variables
│   └── outputs.tf           # Output values
├── .github/
│   └── workflows/
│       └── deploy.yml       # GitHub Actions CI/CD pipeline
├── Dockerfile               # Container definition
├── docker-compose.yml       # Local development setup
└── README.md

---

## Local Development

Prerequisites: Docker Desktop, Python 3.11

git clone https://github.com/avinashmaram/task-manager-devops
cd task-manager-devops
docker-compose up --build

API available at http://localhost:8000
Interactive docs at http://localhost:8000/docs

---

## Deploy to AWS

cd terraform
terraform init
terraform plan -var="db_password=YourPassword"
terraform apply -var="db_password=YourPassword"

---

## Destroy Infrastructure

cd terraform
terraform destroy -var="db_password=YourPassword"

Rebuild anytime with terraform apply — everything provisions in under 5 minutes.

---

Built by Avinash M — SRE / DevOps / Cloud Engineer
