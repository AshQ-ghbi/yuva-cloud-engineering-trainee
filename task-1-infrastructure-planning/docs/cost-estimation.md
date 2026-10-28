# Cost Estimation and Optimization Strategy

## 1. Projected Baseline Monthly Spend
This estimation assumes a baseline traffic model of 15,000 active concurrent users, deployed in the AWS `ap-south-1` (Mumbai) region.

| AWS Service | Purpose | Estimated Monthly Cost (USD) |
| :--- | :--- | :--- |
| **Amazon EC2 (Compute)** | Application servers (ASG baseline capacity) | $450.00 |
| **Amazon Aurora PostgreSQL** | Primary data store (Multi-AZ) | $320.00 |
| **Amazon ElastiCache** | Redis caching for sessions and cart data | $110.00 |
| **Application Load Balancer** | Traffic distribution | $45.00 |
| **AWS CloudFront & WAF** | CDN bandwidth and web security filtering | $150.00 |
| **Amazon S3 & Data Transfer** | Storage for media assets and backups | $85.00 |
| **Total Estimated Baseline** | | **$1,160.00 / month** |

## 2. Cost Optimization Strategies Implemented
To ensure the infrastructure remains cost-effective during both idle periods and flash sales, the following optimizations are part of the architecture:

* **Compute Savings Plans:** 40% of the EC2 compute footprint (the absolute minimum required baseline) is committed to a 3-Year Compute Savings Plan, yielding up to a 66% discount over On-Demand rates.
* **Auto Scaling (Target Tracking):** The remaining 60% of compute capacity is handled dynamically via ASG, spinning down instances during low-traffic night hours to avoid paying for idle resources.
* **S3 Intelligent-Tiering:** Media assets and database snapshots automatically move to lower-cost storage tiers (Infrequent Access and Glacier) after 30 and 90 days of inactivity, respectively.
* **CloudFront Edge Caching:** By caching heavy image files at the CDN edge, we drastically reduce expensive data egress fees from the core AWS VPC.
