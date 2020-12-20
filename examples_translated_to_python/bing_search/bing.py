from hy.core.language import first
import json
import os
import sys
from pprint import pprint
import requests
subscription_key = os.environ['BING_SEARCH_V7_SUBSCRIPTION_KEY']
query = sys.argv[1]
endpoint = 'https://api.cognitive.microsoft.com/bing/v7.0/search'
mkt = 'en-US'
params = {'q': query, 'mkt': mkt}
headers = {'Ocp-Apim-Subscription-Key': subscription_key}
response = requests.get(endpoint, headers=headers, params=params)
print("""
Full JSON response from Bing search query:
""")
pprint(response.json())
results = response.json()['webPages']
print("""
Results from the key 'webPages':
""")
pprint(results)
print("""
Detailed printout from the first search result:
""")
result_list = results['value']
first_result = first(result_list)
print("""
First result, all data:
""")
pprint(first_result)
print("""
Summary of first search result:
""")
pprint(first_result['displayUrl'])
print(' key: {:15} \t:\t {}'.format('displayUrl', first_result['displayUrl'])
    ) if 'displayUrl' in first_result else None
print(' key: {:15} \t:\t {}'.format('language', first_result['language'])
    ) if 'language' in first_result else None
print(' key: {:15} \t:\t {}'.format('name', first_result['name'])
    ) if 'name' in first_result else None

