import hy.macros
from hy.core.language import eval
import json
import requests
hy.macros.require('hy.contrib.walk', None, assignments=[['let', 'let']],
    prefix='')
from cache import fetch_result_dbpedia, save_query_results_dbpedia
wikidata_endpoint = 'https://query.wikidata.org/bigdata/namespace/wdq/sparql'
dbpedia_endpoint = 'https://dbpedia.org/sparql'


def do_query_helper(endpoint, query):
    cached_results = fetch_result_dbpedia(query)
    if len(cached_results) > 0:
        _hyx_letXUffffX1 = {}
        print('Using cached query results')
        _hy_anon_var_2 = eval(cached_results)
    else:
        _hyx_letXUffffX2 = {}
        params = {'query': query, 'format': 'json'}
        response = requests.get(endpoint, params=params)
        json_data = response.json()
        vars = json_data['head']['vars']
        results = json_data['results']
        if 'bindings' in results:
            _hyx_letXUffffX3 = {}
            _hyx_letXUffffX3['bindings'] = results['bindings']
            _hyx_letXUffffX3['qr'] = [[[var, binding[var]['value']] for var in
                vars] for binding in _hyx_letXUffffX3['bindings']]
            save_query_results_dbpedia(query, _hyx_letXUffffX3['qr'])
            _hy_anon_var_1 = _hyx_letXUffffX3['qr']
        else:
            _hy_anon_var_1 = []
        _hy_anon_var_2 = _hy_anon_var_1
    return _hy_anon_var_2


def wikidata_sparql(query):
    return do_query_helper(wikidata_endpoint, query)


def dbpedia_sparql(query):
    return do_query_helper(dbpedia_endpoint, query)

