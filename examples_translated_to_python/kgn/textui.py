from PyInquirer import style_from_dict, Token, prompt, Separator
from pprint import pprint


def select_entities(people, places, organizations):
    choices = []
    choices.append(Separator('- People -'))
    for person in people:
        choices.append({'name': person})
    choices.append(Separator('- Places -'))
    for place in places:
        choices.append({'name': place})
    choices.append(Separator('- Organizations -'))
    for org in organizations:
        choices.append({'name': org})
    questions = [{'type': 'checkbox', 'qmark': '😃', 'message':
        'Select entitites to process', 'name': 'entities', 'choices': choices}]
    return prompt(questions)


def get_query():
    return prompt([{'type': 'input', 'name': 'query', 'message':
        'Enter a list of entities:'}])['query']

