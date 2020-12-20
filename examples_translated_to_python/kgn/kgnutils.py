import hy.macros
from hy.core.language import name
from sparql import dbpedia_sparql
from colorize import colorize_sparql
from pprint import pprint
hy.macros.require('hy.contrib.walk', None, assignments=[['let', 'let']],
    prefix='')


def dbpedia_get_entities_by_name(name, dbpedia_type):
    _hyx_letXUffffX1 = {}
    _hyx_letXUffffX1['sparql'] = (
        'select distinct ?s ?comment {{ ?s ?p "{}"@en . ?s <http://www.w3.org/2000/01/rdf-schema#comment>  ?comment  . FILTER  (lang(?comment) = \'en\') . ?s <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> {} . }} limit 15'
        .format(name, dbpedia_type))
    print('Generated SPARQL to get DBPedia entity URIs from a name:')
    print(colorize_sparql(_hyx_letXUffffX1['sparql']))
    return dbpedia_sparql(_hyx_letXUffffX1['sparql'])

