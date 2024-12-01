import boto3
import sys
import json

bucket_name = sys.argv[1]
s3 = boto3.client('s3')

try:
    s3.head_bucket(Bucket=bucket_name)
    print(json.dumps({"exists": "true"}))  # Output as string
except Exception:
    print(json.dumps({"exists": "false"}))  # Output as string
