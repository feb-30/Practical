import boto3

region = 'eu-west-1'
ec2 = boto3.client('ec2', region_name=region)

response = ec2.describe_instances(
    Filters=[
        {
            'Name': 'tag:'+'Name',
            'Values': ['demo']
        }
    ]
)

instancelist = []
for reservation in (response["Reservations"]):
    for instance in reservation["Instances"]:
        if instance["State"]['Name'] == "running":
            instancelist.append(instance["InstanceId"])

if instancelist != []:
    ec2.stop_instances(InstanceIds=instancelist)
    for i in instancelist:
        print('stopped your instances: ' + str(i))

# https://aws.amazon.com/premiumsupport/knowledge-center/start-stop-lambda-cloudwatch/
# https://www.slsmk.com/using-python-and-boto3-to-get-instance-tag-information/

# Lambda Function

# import boto3
# region = 'us-west-1'
# instances = ['i-12345cb6de4f78g9h', 'i-08ce9b2d7eccf6d26']
# ec2 = boto3.client('ec2', region_name=region)

# def lambda_handler(event, context):
#     ec2.start_instances(InstanceIds=instances)
#     print('started your instances: ' + str(instances))