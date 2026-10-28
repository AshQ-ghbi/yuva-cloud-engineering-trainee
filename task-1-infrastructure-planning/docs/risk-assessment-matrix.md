# Risk Assessment and Mitigation Matrix

The following table identifies potential operational, security, and availability risks for the e-commerce platform and details the cloud-native strategies used to mitigate them.

| Risk ID | Risk / Threat Description | Severity | Probability | Cloud-Native Mitigation Strategy |
| :---: | :--- | :---: | :---: | :--- |
| **R-01** | **Flash-Sale Compute Exhaustion** <br> Sudden 10x traffic spike overwhelms servers before standard autoscaling triggers. | **Critical** | **High** | Implement **AWS Auto Scaling Predictive Scaling** policies based on historical traffic patterns, and offload read-heavy catalog queries to ElastiCache. |
| **R-02** | **Primary Database Node Failure** <br> Hardware degradation causes the primary PostgreSQL master to freeze or crash. | **High** | **Low** | Deploy **Amazon Aurora Multi-AZ**. It features continuous automated health checks and will automatically failover to the standby replica within ~30 seconds with zero data loss. |
| **R-03** | **DDoS and Layer 7 Attacks** <br> Volumetric flood attacks or SQL Injection attempts disrupt service availability. | **Critical** | **Medium** | Enable **AWS Shield Standard** for network layer protection, and attach **AWS WAF** to CloudFront to rate-limit aggressive IPs and block malicious payloads. |
| **R-04** | **Accidental Data Deletion / Ransomware** <br> Critical buckets or snapshots are deleted by compromised credentials. | **High** | **Low** | Enforce **S3 Object Lock** (WORM model), require MFA for bucket deletion, and use AWS Backup with immutable vault locks. |
| **R-05** | **Cloud Budget Overruns** <br> Misconfigured autoscaling scripts provision maximum instances indefinitely. | **Medium** | **High** | Configure hard limits on the Auto Scaling Group (Max Capacity = 20) and utilize **AWS Budgets** to trigger an SNS email alert when spend hits 80% of the monthly forecast. |
