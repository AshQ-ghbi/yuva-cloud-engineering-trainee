# Total Cost of Ownership (TCO) & Optimization Report

## Pre-Migration (On-Premises) vs Post-Migration (AWS Optimized)

| Cost Component | On-Premises (Annual) | AWS Initial Lift-and-Shift | AWS Optimized (Target) | Optimization Strategy Used |
| :--- | :--- | :--- | :--- | :--- |
| **Compute / Servers** | $45,000 | $40,000 | $26,000 | Auto Scaling Groups & 1-Year Compute Savings Plans (No idle servers). |
| **Database Licensing & H/W** | $25,000 | $22,000 | $18,000 | Re-platformed to Amazon RDS; eliminated expensive enterprise licensing. |
| **Storage (SAN vs S3)** | $15,000 | $10,000 | $5,500 | Migrated to Amazon S3 with Intelligent-Tiering (moving stale data to Glacier). |
| **Datacenter Power/Cooling** | $12,000 | $0 | $0 | Completely eliminated by migrating to public cloud. |
| **Total Annual Cost** | **$97,000** | **$72,000** | **$49,500** | **Net Reduction: ~49% from On-Premises, ~31% from unoptimized AWS.** |
