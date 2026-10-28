#!/bin/bash
# Automates the setup of CloudWatch Metric Filters and Alarms for HTTP 5xx Errors

LOG_GROUP="ecommerce-production-access-logs"
METRIC_NAME="HTTP5xxErrorRate"
METRIC_NAMESPACE="EcommerceAppMetrics"
SNS_TOPIC_ARN="arn:aws:sns:ap-south-1:123456789012:Ecommerce-Alerts"

echo "Creating Log Group..."
aws logs create-log-group --log-group-name $LOG_GROUP

echo "Creating Metric Filter for 5xx Errors..."
aws logs put-metric-filter \
  --log-group-name $LOG_GROUP \
  --filter-name "5xxErrors" \
  --filter-pattern '"HTTP/1.1\" 5"' \
  --metric-transformations metricName=$METRIC_NAME,metricNamespace=$METRIC_NAMESPACE,metricValue=1

echo "Creating CloudWatch Alarm..."
aws cloudwatch put-metric-alarm \
  --alarm-name "High-5xx-Error-Rate" \
  --metric-name $METRIC_NAME \
  --namespace $METRIC_NAMESPACE \
  --statistic Sum \
  --period 300 \
  --threshold 50 \
  --comparison-operator GreaterThanOrEqualToThreshold \
  --evaluation-periods 1 \
  --alarm-actions $SNS_TOPIC_ARN

echo "Monitoring Setup Complete!"
