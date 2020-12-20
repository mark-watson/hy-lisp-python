import hy.macros
from hy.core.language import first, name, second
import os
import sys
from pprint import pprint
hy.macros.require('hy.contrib.walk', None, assignments=[['let', 'let']],
    prefix='')
from textui import select_entities, get_query
from kgnutils import dbpedia_get_entities_by_name
from relationships import hyx_entity_results_XgreaterHthan_signXrelationship_links
import spacy
nlp_model = spacy.load('en')


def entities_in_text(s):
    doc = nlp_model(s)
    ret = {}
    for [ename, etype] in [[entity.text, entity.label_] for entity in doc.ents
        ]:
        if etype in ret:
            ret[etype] = ret[etype] + [ename]
            _hy_anon_var_1 = None
        else:
            ret[etype] = [ename]
            _hy_anon_var_1 = None
    return ret


entity_type_to_type_uri = {'PERSON': '<http://dbpedia.org/ontology/Person>',
    'GPE': '<http://dbpedia.org/ontology/Place>', 'ORG':
    '<http://dbpedia.org/ontology/Organisation>'}
short_comment_to_uri = {}


def shorten_comment(comment, uri):
    sc = comment[0:70:None] + '...'
    short_comment_to_uri[sc] = uri
    return sc


query = ''


def kgn():
    while True:
        _hyx_letXUffffX1 = {}
        _hyx_letXUffffX1['query'] = get_query()
        if _hyx_letXUffffX1['query'] == 'quit' or _hyx_letXUffffX1['query'
            ] == 'q':
            break
            _hy_anon_var_4 = None
        else:
            _hy_anon_var_4 = None
        elist = entities_in_text(_hyx_letXUffffX1['query'])
        people_found_on_dbpedia = []
        places_found_on_dbpedia = []
        organizations_found_on_dbpedia = []
        global short_comment_to_uri
        short_comment_to_uri = {}
        for key in elist:
            type_uri = entity_type_to_type_uri[key]
            for name in elist[key]:
                dbp = dbpedia_get_entities_by_name(name, type_uri)
                for d in dbp:
                    short_comment = shorten_comment(second(second(d)),
                        second(first(d)))
                    people_found_on_dbpedia.extend([name + ' || ' +
                        short_comment]) if key == 'PERSON' else None
                    places_found_on_dbpedia.extend([name + ' || ' +
                        short_comment]) if key == 'GPE' else None
                    organizations_found_on_dbpedia.extend([name + ' || ' +
                        short_comment]) if key == 'ORG' else None
        user_selected_entities = select_entities(people_found_on_dbpedia,
            places_found_on_dbpedia, organizations_found_on_dbpedia)
        uri_list = []
        for entity in user_selected_entities['entities']:
            short_comment = entity[4 + entity.index(' || '):None:None]
            uri_list.extend([short_comment_to_uri[short_comment]])
        relation_data = (
            hyx_entity_results_XgreaterHthan_signXrelationship_links(uri_list))
        print('\nDiscovered relationship links:')
        pprint(relation_data)


kgn()

