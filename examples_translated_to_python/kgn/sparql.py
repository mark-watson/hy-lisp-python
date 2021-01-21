from hy.core.language import eval
import json
import requests
from cache import fetch_result_dbpedia, save_query_results_dbpedia
wikidata_endpoint = 'https://query.wikidata.org/bigdata/namespace/wdq/sparql'
dbpedia_endpoint = 'https://dbpedia.org/sparql'


def do_query_helper(endpoint, query):
    cached_results = fetch_result_dbpedia(query)
    if len(cached_results) > 0:
        print('Using cached query results')
        _hy_anon_var_2 = eval(cached_results)
    else:
        params = {'query': query, 'format': 'json'}
        response = requests.get(endpoint, params=params)
        json_data = response.json()
        vars = json_data['head']['vars']
        results = json_data['results']
        if 'bindings' in results:
            bindings = results['bindings']
            qr = [[[var, binding[var]['value']] for var in vars] for
                binding in bindings]
            save_query_results_dbpedia(query, qr)
            _hy_anon_var_1 = qr
        else:
            _hy_anon_var_1 = []
        _hy_anon_var_2 = _hy_anon_var_1
    return _hy_anon_var_2


def wikidata_sparql(query):
    return do_query_helper(wikidata_endpoint, query)


def dbpedia_sparql(query):
    return do_query_helper(dbpedia_endpoint, query)

