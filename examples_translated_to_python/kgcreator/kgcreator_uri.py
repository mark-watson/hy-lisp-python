from hy.core.shadow import _
from os import scandir
from os.path import splitext, exists
import spacy
nlp_model = spacy.load('en')


def find_entities_in_text(some_text):

    def clean(s):
        return s.replace('\n', ' ').strip()
    doc = nlp_model(some_text)
    return map(list, [[clean(entity.text), entity.label_] for entity in doc
        .ents])


def data2Rdf(meta_data, entities, fout):
    for [value, abbreviation] in entities:
        a_literal = '"' + value + '"'
        if value in v2umap:
            a_literal = v2umap[value]
            _hy_anon_var_3 = None
        else:
            _hy_anon_var_3 = None
        fout.write('<' + meta_data + '>\t' + e2umap[abbreviation] + '\t' +
            a_literal + ' .\n') if abbreviation in e2umap else None


e2umap = {'ORG': '<https://schema.org/Organization>', 'LOC':
    '<https://schema.org/location>', 'GPE': '<https://schema.org/location>',
    'NORP': '<https://schema.org/nationality>', 'PRODUCT':
    '<https://schema.org/Product>', 'PERSON': '<https://schema.org/Person>'}
v2umap = {'IBM': '<http://dbpedia.org/page/IBM>', 'The Wall Street Journal':
    '<http://dbpedia.org/page/The_Wall_Street_Journal>', 'Banco Espirito':
    '<http://dbpedia.org/page/Banco_Esp%C3%ADrito_Santo>',
    'Australian Broadcasting Corporation':
    '<http://dbpedia.org/page/Australian_Broadcasting_Corporation>',
    'Australian Writers Guild':
    '<http://dbpedia.org/page/Australian_Broadcasting_Corporation>',
    'Microsoft': '<http://dbpedia.org/page/Microsoft>'}


def process_directory(directory_name, output_rdf):
    _hy_anon_var_7 = None
    with open(output_rdf, 'w') as frdf:
        _hy_anon_var_6 = None
        with scandir(directory_name) as entries:
            for entry in entries:
                [_, file_extension] = splitext(entry.name)
                if file_extension == '.txt':
                    check_file_name = entry.path[0:-4:None] + '.meta'
                    _hy_anon_var_5 = process_file(entry.path,
                        check_file_name, frdf) if exists(check_file_name
                        ) else print('Warning: no .meta file for', entry.
                        path, 'in directory', directory_name)
                else:
                    _hy_anon_var_5 = None
            _hy_anon_var_6 = None
        _hy_anon_var_7 = _hy_anon_var_6
    return _hy_anon_var_7


def process_file(txt_path, meta_path, frdf):

    def read_data(text_path, meta_path):
        _hy_anon_var_9 = None
        with open(text_path) as f:
            t1 = f.read()
            _hy_anon_var_9 = None
        _hy_anon_var_10 = None
        with open(meta_path) as f:
            t2 = f.read()
            _hy_anon_var_10 = None
        return [t1, t2]

    def modify_entity_names(ename):
        return ename.replace('the ', '')
    [txt, meta] = read_data(txt_path, meta_path)
    entities = find_entities_in_text(txt)
    entities = [[modify_entity_names(e), t] for [e, t] in entities if t in
        ['NORP', 'ORG', 'PRODUCT', 'GPE', 'PERSON', 'LOC']]
    return data2Rdf(meta, entities, frdf)


process_directory('test_data', 'output.rdf')

