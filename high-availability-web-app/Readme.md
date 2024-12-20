Project Overview
Objective:
Use Terraform for infrastructure provisioning on AWS.
Use Ansible for application configuration and deployment.
Ensure high availability and scalability of the web application.
Project Workflow
Terraform:

Create a VPC with public and private subnets.
Launch EC2 instances in an Auto Scaling group.
Set up an Application Load Balancer (ALB) for load balancing.
Provision an RDS instance for the application database.
Ansible:

Configure EC2 instances (install Nginx, deploy app code, set up monitoring tools).
Automate the process using playbooks.
Integration:

Terraform generates an inventory file with EC2 instance details.
Ansible uses this inventory for configuration.
Implementation Steps
Step 1: Directory Structure
![image](https://github.com/user-attachments/assets/a1ab7e21-78ef-40a4-b361-34844e93fb55)

Step 2: Terraform Code
provider.tf

variables.tf

main.tf

outputs.tf

Step 3: Ansible Configuration
Dynamic Inventory
Create a dynamic inventory script: ansible/inventory/dynamic_inventory.py

Playbook 1: Install and Configure Nginx
ansible/playbooks/nginx_setup.yml

Playbook 2: Deploy Application Code
ansible/playbooks/app_deployment.yml


Playbook 3: Monitoring Setup
ansible/playbooks/monitoring_setup.yml

Step 4: Execute the Workflow
Provision Infrastructure:

cd terraform/
terraform init
terraform apply
Run Ansible Playbooks:


cd ../ansible/
ansible-playbook -i inventory/dynamic_inventory.py playbooks/nginx_setup.yml
ansible-playbook -i inventory/dynamic_inventory.py playbooks/app_deployment.yml
ansible-playbook -i inventory/dynamic_inventory.py playbooks/monitoring_setup.yml

Step 5: Verify the Deployment
Access the Load Balancer DNS to verify the web application.
Check logs in CloudWatch to ensure monitoring is working.
