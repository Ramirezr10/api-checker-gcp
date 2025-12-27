GCP Website Health Monitor

A cloud-native observability solution that monitors website uptime using a Python agent. This project demonstrates SRE (Site Reliability Engineering) principles, including Infrastructure-as-Code (IaC), automated bootstrapping, and centralized logging.

🏗️ Architecture

    Infrastructure: Fully automated via Terraform (VPC, Firewall, GCE).

    Compute: Ubuntu 22.04 LTS (e2-micro) running as a dedicated monitoring node.

    Bootstrapping: Uses Cloud-Init (Startup Scripts) to automatically install dependencies and start the agent on boot.

    Observability: Custom log streaming to GCP Cloud Logging for real-time heartbeats.

🚀 Features

    Zero-Touch Deployment: Terraform handles both the infrastructure and the initial script setup.

    Keyless Security: Uses Application Default Credentials (ADC) and IAM Service Account bindings—no JSON keys stored on the VM.

    Automated Lifecycle: Configured with allow_stopping_for_update for seamless IaC-driven instance management.

🛠 Tech Stack

    Cloud: Google Cloud Platform (GCP)

    IaC: Terraform

    Language: Python 3.10+

    Security: IAM Roles & Service Accounts

📊 Monitoring in GCP

You don't need to manually check the VM. Simply go to GCP Logs Explorer and filter by:
SQL

logName:"logs/health-checker-logs"

🧠 Key Technical Challenges Solved
1. The "Manual IAM" Trap

Challenge: Initially required manual gcloud commands to grant logging permissions. Solution: Integrated the google_project_iam_member resource into Terraform. Now, the logging.logWriter role is applied automatically to the Service Account during terraform apply.
2. Dependency Management at Scale

Challenge: Manually SSHing to install Python packages is not scalable. Solution: Implemented a Metadata Startup Script in Terraform. The VM now self-provisions its environment (venv, requests, google-cloud-logging) immediately upon creation.
3. API Access Scopes

Challenge: Encounted 403 Permission Denied despite correct IAM roles. Solution: Identified that GCE instances require the cloud-platform access scope to allow IAM roles to function fully. Updated the Terraform service_account block to include the correct scopes.

🧹 Clean Up
```Bash
terraform destroy -auto-approve
