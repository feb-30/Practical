import sys
import requests
import json

r = requests.get('http://spot-price.s3.amazonaws.com/spot.js')
# try:
# Get the jsonp spot price data from amazon
# http = urllib3.PoolManager()
# r = http.request('GET', '')
# _data = r.data

# d = json.dumps(_data )
print(r.data)