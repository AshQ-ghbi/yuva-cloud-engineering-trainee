# Migration Strategy: 6-R Framework

## 1. Relational Database (MySQL 5.7) -> Re-platform
* **Strategy:** Move from self-managed on-premises hardware to **Amazon RDS for MySQL (Multi-AZ)**.
* **Rationale:** Offloads database patching, backups, and failover management to AWS, significantly reducing operational overhead while maintaining compatibility.
* **Tooling:** AWS Database Migration Service (DMS) for continuous replication and zero-downtime cutover.

## 2. Web & Application Servers -> Re-host (Lift & Shift) then Re-platform
* **Phase 1 (Migration):** Migrate existing VMs directly to **Amazon EC2** using AWS Application Migration Service (MGN).
* **Phase 2 (Optimization):** Transition workloads into an Auto Scaling Group (ASG) behind an Application Load Balancer to achieve horizontal elasticity.

## 3. Static Media Files (NAS Storage) -> Refactor
* **Strategy:** Move from costly on-premises SAN/NAS to **Amazon S3**.
* **Rationale:** Infinite scalability, native integration with AWS CloudFront CDN, and lifecycle policies (S3 Intelligent-Tiering) to reduce long-term storage costs.

## 4. Legacy Analytics Server -> Retire
* **Strategy:** Decommission the hardware.
* **Rationale:** Analytics will be handled natively by Amazon QuickSight connected to RDS read replicas, rendering the old physical server obsolete.
