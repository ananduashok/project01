# 🚀 Automated Static Website Deployment (Project 01)

This project demonstrates a complete **CI/CD Pipeline** for a static website. It bridges the gap between code and cloud by using **Infrastructure as Code (IaC)** and **Automated Workflows**.

## 🏗️ Architecture Overview
The goal of this project is to move from manual uploads to a "Push-to-Deploy" model.

**The Flow:** 
`Developer` $\rightarrow$ `Git Push` $\rightarrow$ `GitHub Actions` $\rightarrow$ `AWS S3` $\rightarrow$ `End User`

- **Infrastructure:** AWS S3 (Static Website Hosting)
- **Provisioning:** Terraform (IaC)
- **CI/CD Pipeline:** GitHub Actions
- **Source Control:** GitHub

---

## 🛠️ Technologies Used
| Tool | Purpose |
| :--- | :--- |
| **Terraform** | To provision the S3 bucket and configure public access policies without using the AWS Console. |
| **AWS S3** | To host the static HTML files and serve them to the public. |
| **GitHub Actions** | To automate the synchronization of files from the repository to the S3 bucket on every push. |
| **Git** | For version control and triggering the automation. |

---

## 🚀 Getting Started

### 1. Prerequisites
- An **AWS Account** (Free Tier).
- **Terraform** installed locally.
- **AWS CLI** configured.
- A **GitHub Account**.

### 2. Infrastructure Setup (The "Ops" Part)
Instead of creating the bucket manually, we use Terraform:
1. Navigate to the project root.
2. Initialize Terraform: `terraform init`
3. Review the plan: `terraform plan`
4. Deploy the bucket: `terraform apply -auto-approve`

This creates an S3 bucket, disables "Block Public Access," and applies a bucket policy allowing `s3:GetObject` for everyone.

### 3. Setting up the Pipeline (The "Dev" Part)
To allow GitHub to talk to AWS, you must set up **Repository Secrets** in GitHub (`Settings` $\rightarrow$ `Secrets and variables` $\rightarrow$ `Actions`):
- `AWS_ACCESS_KEY_ID`: Your IAM user access key.
- `AWS_SECRET_ACCESS_KEY`: Your IAM user secret key.
- `AWS_S3_BUCKET`: The name of your S3 bucket (e.g., `anandu-devops-project-1-tf`).

### 4. Deploying Changes
Any change made to `index.html` and pushed to the `main` branch will trigger the `.github/workflows/deploy.yml` workflow, which syncs the local files to the S3 bucket.

```bash
git add .
git commit -m "Updated website content"
git push origin main