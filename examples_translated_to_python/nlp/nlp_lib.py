import argparse
import os
import spacy
nlp_model = spacy.load('en')


def nlp(some_text):
    doc = nlp_model(some_text)
    entities = [[entity.text, entity.label_] for entity in doc.ents]
    j = doc.to_json()
    j['entities'] = entities
    return j


print(nlp('President George Bush went to Mexico and he had a very good meal'))
print(nlp('Lucy threw a ball to Bill and he caught it'))

