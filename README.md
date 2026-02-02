# AWS RDS Start/Stop Scheduler (Cost Optimization)

A serverless solution to automatically start and stop Amazon RDS instances
for non-production environments using AWS native services.

## 🛠 Architecture
- Amazon EventBridge (cron scheduling)
- AWS Lambda (RDS start/stop logic)
- Amazon SNS (email notifications)
- Terraform (Infrastructure as Code)

## 🚀 Use Case
- Dev / QA environments
- Cost optimization
- Avoid manual RDS operations

## ⚙️ How It Works
1. EventBridge triggers Lambda on a cron schedule
2. Lambda checks RDS state and starts/stops safely
3. SNS sends email notification to stakeholders

## 📦 Deployment
```bash
cd terraform
terraform init
terraform plan
terraform apply
