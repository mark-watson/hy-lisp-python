# Notes for running the natural language processing (NLP) examples

Make sure that spacy and neuralcoref are installed in your current Python environment. Follow
directions at:

        https://github.com/huggingface/neuralcoref

Note: the neuralcoref library is outdated and only can be installed with the older version of spaCy 2.1

## Misc. to install spaCy on M1 MacBook

pip install -U pip setuptools wheel
pip install -U 'spacy[apple]'
python -m spacy download en_core_web_sm

