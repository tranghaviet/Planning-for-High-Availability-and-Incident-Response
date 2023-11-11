# Infrastructure

## AWS Zones

us-east-2 (zone 1), us-west-1 (zone 2)

## Servers and Clusters

### Table 1.1 Summary

| Asset              | Purpose                       | Size        | Qty | DR                                                             |
|--------------------|-------------------------------|-------------|-----|----------------------------------------------------------------|
| EC2 instances      | Run the app                   | t3.micro    | 6   | in 2 zones, 3 in each zone for DR                              |
| SSH Key pairs      | SSH to EC2                    | -           | 2   | in 2 zones, each zone imports 1 key for DR                     |
| EKS                | Kubernetes cluster            | t3.medium   | 2   | in 2 zones, each zone has one for DR                           |
| VPC                | Virtual Private Cloud network | -           | 2   | in 2 zones, each has one, created in multiple locations for DR |
| Terraform          | Deploy IaC                    | -           | 2   | stored at local for DR                                         |
| RDS                | backend databases             | db.t2.small | 2   | 2 nodes in zone 1                                              |
| RDS                | backend databases             | db.t2.small | 2   | 2 nodes in zone 2 replicated of RDS in zone 1, use for DR      |
| ALB                | application load balancer     | -           | 2   | in 2 zones, each has one for HA and DR                         |
| Grafana Prometheus | monitoring system             | -           | 2   | in 2 zones, each has one for DR                                |
| S3 Bucket          | store Terraform               | -           | 2   | in 2 zones, each has one for DR                                |


### Descriptions

- EC2 instances: Virtual servers in the cloud run the app.
- SSH Key pairs: Secure remote access keys for EC2 instances.
- EKS: Managed Kubernetes service on AWS to run Grafana Prometheus.
- VPC: Virtual network for launching resources on AWS.
- Terraform: Infrastructure as code tool for automating resource provisioning.
- RDS: Managed database service for relational databases.
- ALB: Load balancing service for distributing application traffic.
- Grafana Prometheus: Analytics and monitoring platform for metrics and logs.
- S3 Bucket: Scalable object storage for Terraform.

## DR Plan
### Pre-Steps:

- Identify critical assets: Determine important IT assets and systems to protect and recover in a disaster.
- Conduct risk assessment: Evaluate potential risks and threats to your infrastructure.
- Define recovery objectives: RTO and RPO for each asset.
- Assess dependencies: Identify dependencies between assets and systems.
- Determine backup strategies: Define backup frequency, retention periods, and storage locations.
- Establish communication channels: Set up effective communication channels during a disaster.
- Document the DR plan: Create a comprehensive document outlining the steps and procedures.
- Test and validate the plan: Regularly test and validate the DR plan's effectiveness.

- Identify the resources and services needed in the new region.
- Create a new VPC (Virtual Private Cloud) in the desired region.
- Set up the necessary networking components like subnets, route tables, and internet gateways.
Launch EC2 instances and configure them with the required software and security settings.
Set up an EKS cluster if needed and deploy containerized applications.
Provision an RDS database instance and configure it with the desired settings.
Configure an ALB (Application Load Balancer) to distribute traffic to the EC2 instances or EKS services.
Set up monitoring and logging using tools like Grafana and Prometheus.
Create an S3 bucket for storing files and data.
Use Terraform or other infrastructure as code tools to automate the provisioning and configuration process.

## Steps:

- Fail over the database (RDS) instance from the primary region (us-east-2) to the secondary region (us-west-1).
- Point the load balancer DNS to the secondary region.
