import hy.macros
from hy.core.language import flatten
from pprint import pprint
hy.macros.require('hy.contrib.walk', None, assignments=[['let', 'let']],
    prefix='')
from sparql import dbpedia_sparql
from colorize import colorize_sparql


def dbpedia_get_relationships(s_uri, o_uri):
    _hyx_letXUffffX1 = {}
    _hyx_letXUffffX1['query'] = (
        "SELECT DISTINCT ?p {{  {} ?p {} . FILTER (!regex(str(?p), 'wikiPage', 'i')) }} LIMIT 5"
        .format(s_uri, o_uri))
    _hyx_letXUffffX1['results'] = dbpedia_sparql(_hyx_letXUffffX1['query'])
    print('Generated SPARQL to get relationships between two entities:')
    print(colorize_sparql(_hyx_letXUffffX1['query']))
    return [r for r in flatten(_hyx_letXUffffX1['results']) if not r == 'p']


def hyx_entity_results_XgreaterHthan_signXrelationship_links(uris):
    uris = [('<' + uri + '>') for uri in uris]
    relationship_statements = []
    for e1 in uris:
        for e2 in uris:
            if not e1 == e2:
                _hyx_letXUffffX2 = {}
                _hyx_letXUffffX2['l1'] = dbpedia_get_relationships(e1, e2)
                _hyx_letXUffffX2['l2'] = dbpedia_get_relationships(e2, e1)
                for x in _hyx_letXUffffX2['l1']:
                    relationship_statements.extend([[e1, e2, x]]) if not [e1,
                        e2, x] in relationship_statements else None
                for x in _hyx_letXUffffX2['l2']:
                    relationship_statements.extend([[e1, e2, x]]) if not [e1,
                        e2, x] in relationship_statements else None
                _hy_anon_var_2 = None
            else:
                _hy_anon_var_2 = None
    return relationship_statements

