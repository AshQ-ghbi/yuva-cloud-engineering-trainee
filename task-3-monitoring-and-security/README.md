# Monitoring, Logging, and Cloud Security Setup

## Overview
This module contains the configuration files and scripts used to establish a robust monitoring, centralized logging, and security posture for a cloud-native AWS environment. 

## Contents
* **`configs/cloudwatch-agent-config.json`**: Collects system-level metrics (memory, disk usage) and pushes application logs to CloudWatch.
* **`configs/waf-rules.json`**: AWS WAF Web ACL rules to mitigate SQL Injection (SQLi) and rate-limit HTTP floods.
* **`configs/iam-least-privilege-policy.json`**: IAM Role policy attached to EC2 instances, enforcing least-privilege access.
* **`scripts/metric-filters.sh`**: AWS CLI automation script to create log groups, set metric filters for HTTP 5xx errors, and provision SNS alarms.
