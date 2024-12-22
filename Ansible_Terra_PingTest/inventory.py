#!/usr/bin/env python

import boto3
import json

# Initialize boto3 EC2 client
ec2_client = boto3.client('ec2', region_name='us-east-1')

def get_instances():
    # Filter instances by tag (optional)
    response = ec2_client.describe_instances(
        Filters=[{'Name': 'tag:Name', 'Values': ['Target-1', 'Target-2']}]
    )

    instances = []
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instances.append({
                'hostname': instance['PublicIpAddress'],
                'name': instance['Tags'][0]['Value'],
                'private_ip': instance['PrivateIpAddress'],
            })
    return instances

def generate_inventory():
    inventory = {'_meta': {'hostvars': {}}}

    instances = get_instances()
    
    # Populate the inventory
    for instance in instances:
        hostname = instance['hostname']
        inventory[hostname] = {'hosts': [hostname]}
        inventory['_meta']['hostvars'][hostname] = {
            'private_ip': instance['private_ip']
        }

    return inventory

if __name__ == '__main__':
    print(json.dumps(generate_inventory(), indent=4))
