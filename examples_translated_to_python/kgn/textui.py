import hy.macros
from PyInquirer import style_from_dict, Token, prompt, Separator
from pprint import pprint
hy.macros.require('hy.contrib.walk', None, assignments=[['let', 'let']],
    prefix='')


def select_entities(people, places, organizations):
    _hyx_letXUffffX1 = {}
    _hyx_letXUffffX1['choices'] = []
    _hyx_letXUffffX1['choices'].append(Separator('- People -'))
    for person in people:
        _hyx_letXUffffX1['choices'].append({'name': person})
    _hyx_letXUffffX1['choices'].append(Separator('- Places -'))
    for place in places:
        _hyx_letXUffffX1['choices'].append({'name': place})
    _hyx_letXUffffX1['choices'].append(Separator('- Organizations -'))
    for org in organizations:
        _hyx_letXUffffX1['choices'].append({'name': org})
    questions = [{'type': 'checkbox', 'qmark': '😃', 'message':
        'Select entitites to process', 'name': 'entities', 'choices':
        _hyx_letXUffffX1['choices']}]
    return prompt(questions)


def get_query():
    return prompt([{'type': 'input', 'name': 'query', 'message':
        'Enter a list of entities:'}])['query']

