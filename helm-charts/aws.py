# links:
# Spot prices:
# https://stackoverflow.com/questions/43586181/how-can-one-get-current-spot-price-via-boto
# Normal Prices:
# https://stackoverflow.com/questions/51673667/use-boto3-to-get-current-price-for-given-ec2-instance-type
# https://aws.amazon.com/blogs/aws/aws-price-list-api-update-new-query-and-metadata-functions/
#


# Credentials on instance
# https://stackoverflow.com/questions/49496141/fetch-boto3-credentials-only-from-ec2-instance-profile
# from botocore.credentials import InstanceMetadataProvider, InstanceMetadataFetcher
#
# provider = InstanceMetadataProvider(iam_role_fetcher=InstanceMetadataFetcher(timeout=1000, num_attempts=2))
# creds = provider.load().get_frozen_credentials()
#
# client = boto3.client('ssm', region_name='us-east-1', aws_access_key_id=creds.access_key, aws_secret_access_key=creds.secret_key, aws_session_token=creds.token)

import json
import pprint

import boto3
from pkg_resources import resource_filename


# Search product filter
FLT = '[{{"Field": "tenancy", "Value": "shared", "Type": "TERM_MATCH"}},' \
      '{{"Field": "operatingSystem", "Value": "{o}", "Type": "TERM_MATCH"}},' \
      '{{"Field": "preInstalledSw", "Value": "NA", "Type": "TERM_MATCH"}},' \
      '{{"Field": "instanceType", "Value": "{t}", "Type": "TERM_MATCH"}},' \
      '{{"Field": "location", "Value": "{r}", "Type": "TERM_MATCH"}}]'


# Get current AWS price for an on-demand instance
def get_price(region, instance, os, end_point, region_name):
    if end_point == 'api.pricing.ap-south-1.amazonaws.com':
        client = boto3.client('pricing', region_name=region_name)
    elif end_point == 'api.pricing.ap-south-1.amazonaws.com':
        client = boto3.client('pricing', region_name=region_name)
    else:
        client = boto3.client('pricing', region_name='us-east-1')

    f = FLT.format(r=region, t=instance, o=os)

    data = client.get_products(ServiceCode='AmazonEC2', Filters=json.loads(f))
    od = json.loads(data['PriceList'][0])['terms']['OnDemand']

    instanc_type = json.loads(data['PriceList'][0])[
        'product']['attributes']['instanceType']
    if instance != instanc_type:
        print('instance missmatch')
    id1 = list(od)[0]

    id2 = list(od[id1]['priceDimensions'])[0]
    if '0.0000000000' == od[id1]['priceDimensions'][id2]['pricePerUnit']['USD']:
        if len(data['PriceList']) > 1:
            od = json.loads(data['PriceList'][1])['terms']['OnDemand']
            id1 = list(od)[0]
            id2 = list(od[id1]['priceDimensions'])[0]

    return od[id1]['priceDimensions'][id2]['pricePerUnit']['USD'], instanc_type


# Translate region code to region name
def get_region_name(region_code):
    default_region = 'EU (Ireland)'
    endpoint_file = resource_filename('botocore', 'data/endpoints.json')
    try:
        with open(endpoint_file, 'r') as f:
            data = json.load(f)
        return data['partitions'][0]['regions'][region_code]['description']
    except IOError:
        return default_region


def compare_prices(instancetypes=['p2.xlarge', 'p2.8xlarge', 'p2.16xlarge', 'p3.2xlarge', 'p3.8xlarge', 'p3.16xlarge', 'p3dn.24xlarge']):
    resp = []
    ec2 = boto3.client('ec2', region_name='us-west-1')
    regions = ec2.describe_regions()['Regions']
    for reg in regions:
        # print(reg)
        regclient = boto3.client('ec2', region_name=reg['RegionName'])

        response = regclient.describe_availability_zones()
        # print('Availability Zones:', response['AvailabilityZones'])

        for zone in response['AvailabilityZones']:

            try:
                prices = regclient.describe_spot_price_history(InstanceTypes=instancetypes,
                                                               ProductDescriptions=[
                                                                   'Linux/UNIX (Amazon VPC)'],
                                                               AvailabilityZone=zone['ZoneName'], MaxResults=1)

                for spot in prices['SpotPriceHistory']:
                    print(spot['InstanceType'], spot['SpotPrice'])
                    on_demand = get_price(get_region_name(
                        reg['RegionName']), spot['InstanceType'], 'Linux', reg['Endpoint'], reg['RegionName'])
                    resp.append(
                        {'spot_instance': spot, 'on_demand': on_demand})

                    print('on demand price: ', on_demand)
            except Exception as exc:
                print(exc)
    return resp


def get_gpu_instances():
    pricing = boto3.client('pricing', region_name='us-east-1')
    response = pricing.get_products(
        ServiceCode='AmazonEC2',
        Filters=[


            {'Type': 'TERM_MATCH', 'Field': 'instanceFamily', 'Value': 'GPU instance'},
            {'Type': 'TERM_MATCH', 'Field': 'operatingSystem', 'Value': 'Linux'},

        ],
        MaxResults=100
    )

    return list(set([json.loads(res)['product']['attributes']['instanceType'] for res in response['PriceList']]))


def find_lawest_price(prices):
    l = []
    lowest = None
    for r in prices:
        if lowest:
            if float(r['spot_instance']['SpotPrice']) < float(lowest['spot_instance']['SpotPrice']):
                lowest = r

        else:
            lowest = r

    l.append(lowest)
    for r in prices:
        if lowest:
            if float(r['spot_instance']['SpotPrice']) == float(lowest['spot_instance']['SpotPrice']) and lowest['spot_instance']['AvailabilityZone'] != r['spot_instance']['AvailabilityZone']:
                l.append(r)
    return l


print(get_gpu_instances())
print(find_lawest_price(compare_prices(['p2.xlarge'])))

