import boto3

# region = 'eu-west-1'
# instanceOne ='instance-one'
# instanceTwo ='instance-two'

# def lambda_handler(event, context):
#     RDS = boto3.client('rds', region_name=region)
#     responseOne = RDS.start_db_instance(DBInstanceIdentifier=instanceOne)
#     responseTwo = RDS.start_db_instance(DBInstanceIdentifier=instanceTwo)


region = 'eu-west-1'
rds = boto3.client('rds', region_name=region)
instances = rds.describe_db_instances()['DBInstances']

rdsInstances = []
if instances:
    for i in instances:
        print(i)
        if (i['DBInstanceStatus']) == 'stopped':
            arn = i['DBInstanceArn']
            RDSInstance = i['DBInstanceIdentifier']
            tags = rds.list_tags_for_resource(ResourceName=arn)['TagList']
            for tag in tags:
                if tag["Value"] == 'demo':
                    rdsInstances.append(RDSInstance)
                    print(rdsInstances)

if rdsInstances != []:
    for i in rdsInstances:
        rds.start_db_instance(DBInstanceIdentifier=i)
        print('started your RDS instances: ' + str(i))
else:
    print('Everything Looks Good')

# https://www.sqlshack.com/automatically-start-stop-an-aws-rds-sql-server-using-aws-lambda-functions/
