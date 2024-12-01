import boto3
import sys

bucket_name = sys.argv[1]
s3 = boto3.client('s3')

try:
    s3.head_bucket(Bucket=bucket_name)
    print(f'{{"exists": true}}')
except:
    print(f'{{"exists": false}}')
