# Task Manager API — DevOps Portfolio Project

A production-grade REST API deployed on AWS using modern DevOps practices including Infrastructure as Code, CI/CD automation, containerization, and cloud monitoring.

---

## Architecture Overview

```
Developer → GitHub → GitHub Actions CI/CD → AWS EC2
                                          → AWS RDS PostgreSQL
                                          → AWS S3
                                          → AWS CloudWatch
```

The project follows a two-phase deployment model:
- **Phase 1 — Infrastructure:** Terraform provisions all AWS resources
- **Phase 2 — Deployment:** GitHub Actions automatically builds and deploys on every git push

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

- **REST API** with full CRUD operations for task management
- **Automated CI/CD** — every push to main triggers tests and deployment
- **Infrastructure as Code** — entire AWS infrastructure defined in Terraform
- **Containerized** — Docker ensures consistent environments
- **Monitored** — CloudWatch dashboards, logs, and CPU alerts
- **Tested** — automated pytest suite runs on every pull request

---

## API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| GET | `/health` | Health check |
| GET | `/tasks` | Get all tasks |
| POST | `/tasks` | Create a new task |
| PUT | `/tasks/{id}` | Update task status |
| DELETE | `/tasks/{id}` | Delete a task |

Interactive API documentation available at `/docs` when running.

---

## Project Structure

```
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
```

---

## AWS Infrastructure

All infrastructure is provisioned via Terraform:

- **VPC** with public and private subnets across multiple availability zones
- **EC2 t3.micro** — application server running Docker container
- **RDS PostgreSQL db.t3.micro** — managed database with automated backups
- **S3 Bucket** — file storage with versioning
- **Security Groups** — firewall rules for app and database tiers
- **Internet Gateway + Route Tables** — public internet access
- **CloudWatch Log Group** — centralized application logs
- **CloudWatch Alarm** — CPU utilization alert at 80% threshold

---

## CI/CD Pipeline

The GitHub Actions pipeline runs automatically on every push to main:

```
Push to main
    │
    ▼
Test Job
├── Install Python dependencies
├── Run pytest suite
└── Report results
    │
    ▼ (only if tests pass)
Build & Deploy Job
├── Configure AWS credentials
├── Build Docker image
├── SSH into EC2
├── Load Docker image
└── Restart container with new version
```

---

## Local Development

**Prerequisites:** Docker Desktop, Python 3.11

```bash
# Clone the repository
git clone https://github.com/avinashmaram/task-manager-devops
cd task-manager-devops

# Start locally with Docker Compose
docker-compose up --build

# API available at http://localhost:8000
# Interactive docs at http://localhost:8000/docs
```

---

## Deploy to AWS

**Prerequisites:** AWS CLI configured, Terraform installed

```bash
# Initialize Terraform
cd terraform
terraform init

# Preview infrastructure changes
terraform plan -var="db_password=YourPassword"

# Deploy infrastructure
terraform apply -var="db_password=YourPassword"

# Outputs will show:
# app_public_ip = "your EC2 IP"
# db_endpoint   = "your RDS endpoint"
# s3_bucket     = "your bucket name"
```

After Terraform completes, add these GitHub Secrets to trigger automated deployment:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `EC2_HOST` — from terraform output
- `EC2_SSH_KEY` — contents of your PEM key file
- `DATABASE_URL` — PostgreSQL connection string

---

## Monitoring

**CloudWatch Dashboard** — tracks EC2 CPU, network traffic, and application logs

**View application logs:**
```bash
# SSH into EC2
ssh -i your-key.pem ec2-user@YOUR-EC2-IP

# View running containers
docker ps

# Tail application logs
docker logs -f task-manager
```

**CloudWatch Alarm** — triggers when CPU exceeds 80% for 4 minutes

---

## Destroy Infrastructure

To avoid AWS charges when not in use:
```bash
cd terraform
terraform destroy -var="db_password=YourPassword"
```

Rebuild anytime with `terraform apply` — everything provisions in under 5 minutes.

---

## Key Learnings

This project demonstrates end-to-end ownership of:
- Designing and provisioning cloud infrastructure using IaC principles
- Building automated CI/CD pipelines with testing gates
- Containerizing applications for consistent deployments
- Implementing cloud monitoring and alerting
- Managing secrets securely in CI/CD environments
- Following GitOps practices with infrastructure and application code in version control

---

*Built by Avinash M — SRE / DevOps / Cloud Engineer*