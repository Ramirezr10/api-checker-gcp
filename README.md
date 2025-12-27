GCP Website Health Monitor (Infrastructure-as-Code)

A cloud-native observability project that monitors website uptime using a Python agent deployed on a Google Compute Engine (GCE) instance. The project demonstrates full-stack SRE principles, including Infrastructure-as-Code (IaC), IAM security, and centralized logging.

🏗️ Architecture

Infrastructure: Provisioned via Terraform (VPC, Firewall, Compute Engine).

Compute: Ubuntu 22.04 LTS (e2-micro).

Monitoring Agent: Python 3 script using requests and google-cloud-logging.

Observability: Real-time log streaming to GCP Logs Explorer.

🚀 Quick Start

1. Provision Infrastructure

On your local machine, navigate to the terraform directory:

terraform init
terraform apply -auto-approve


2. Configure IAM Permissions

Grant the VM's Service Account permission to write to Cloud Logging (Replace with your project details):

gcloud projects add-iam-policy-binding [PROJECT_ID] \
  --member="serviceAccount:[PROJECT_NUMBER]-compute@developer.gserviceaccount.com" \
  --role="roles/logging.logWriter"


3. Deploy & Run Agent

SSH into the instance and start the monitoring service:

# SSH into the VM
gcloud compute ssh health-checker-vm

# Setup environment and run
cd monitor
source venv/bin/activate
python3 main.py


📊 Monitoring in GCP

To view the heartbeats and status checks, go to GCP Logs Explorer and run:

logName:"logs/health-checker-logs"


🛠️ Key Technical Challenges Solved

IAM & API Scopes: Resolved 403 Permission Denied errors by aligning IAM Roles with GCE Access Scopes (cloud-platform).

Terraform Lifecycle: Managed sensitive VM updates using allow_stopping_for_update to automate infrastructure changes that require instance termination.

Service Account Auth: Implemented "Application Default Credentials" (ADC) to allow the Python script to authenticate securely without hardcoded keys.

🧹 Clean Up

To remove all resources and avoid costs:

terraform destroy -auto-approve
