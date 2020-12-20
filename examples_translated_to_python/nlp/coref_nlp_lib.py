import argparse
import os
import spacy
import neuralcoref
nlp2 = spacy.load('en')
neuralcoref.add_to_pipe(nlp2)


def coref_nlp(some_text):
    doc = nlp2(some_text)
    return {'corefs': doc._.coref_resolved, 'clusters': doc._.
        coref_clusters, 'scores': doc._.coref_scores}

