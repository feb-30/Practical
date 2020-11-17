# import boto3
# import os

# region = os.environ['region']
# tagname = os.environ['tagname']
# tagvalue = os.environ['tagvalue']

# def lambda_handler(event, context):
#     ec2 = boto3.client('ec2', region_name=region)
#     response = ec2.describe_instances(
#         Filters=[{
#             'Name': 'tag:'+tagname,
#             'Values': [tagvalue]
#         }]
#     )

#     instancelist = []
#     for reservation in (response["Reservations"]):
#         for instance in reservation["Instances"]:
#             if instance["State"]['Name'] == "stopped":
#                 instancelist.append(instance["InstanceId"])

#     if instancelist != []:
#         ec2.start_instances(InstanceIds=instancelist)
#         for instance in instancelist:
#             print('instance name: ' + str(instance))


import boto3

ec2 = boto3.resource('ec2')
ec2client = boto3.client('ec2')


def lambda_handler(event, context):

    instances = ec2client.describe_instances(Filters=[{'Name': 'tag:kloud_managed', 'Values': ['True']}])
    dict={}

    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
           for tag in instance['Tags']:
                if tag['Key'] == 'Name':
                    dict[instance['InstanceId']]= tag['Value']

    volumes = ec2.volumes.all()
    for volume in volumes:

        for a in volume.attachments:
            for key, value in dict.items():

            if a['InstanceId'] == key:
                     volume.create_tags(Tags=[{'Key': 'Kloud_Name', 'Value': value}])