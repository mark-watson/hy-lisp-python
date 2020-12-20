from hy.core.language import first, last
from keras.callbacks import LambdaCallback
from keras.models import Sequential
from keras.layers import Dense, LSTM
from keras.optimizers import RMSprop
from keras.utils.data_utils import get_file
import numpy as np
import random
import sys
import io
path = get_file('nietzsche.txt', origin=
    'https://s3.amazonaws.com/text-datasets/nietzsche.txt')
_hy_anon_var_1 = None
with io.open(path, encoding='utf-8') as f:
    text = f.read()
    _hy_anon_var_1 = None
print('corpus length:', len(text))
chars = sorted(list(set(text)))
print('total chars (unique characters in input text):', len(chars))
char_indices = dict([(last(i), first(i)) for i in enumerate(chars)])
indices_char = dict([i for i in enumerate(chars)])
maxlen = 40
step = 3
sentences = list()
next_chars = list()
print('Create sentences and next_chars data...')
for i in range(0, len(text) - maxlen, step):
    sentences.append(text[i:i + maxlen:None])
    next_chars.append(text[i + maxlen])
print('Vectorization...')
x = np.zeros([len(sentences), maxlen, len(chars)], dtype=np.bool)
y = np.zeros([len(sentences), len(chars)], dtype=np.bool)
for [i, sentence] in [j for j in enumerate(sentences)]:
    for [t, char] in [j for j in enumerate(sentence)]:
        x[i][t][char_indices[char]] = 1
    y[i][char_indices[next_chars[i]]] = 1
print('Done creating one-hot encoded training data.')
print('Building model...')
model = Sequential()
model.add(LSTM(128, input_shape=[maxlen, len(chars)]))
model.add(Dense(len(chars), activation='softmax'))
optimizer = RMSprop(0.01)
model.compile(loss='categorical_crossentropy', optimizer=optimizer)


def sample(preds, temperature=1.0):
    preds = np.array(preds).astype('float64')
    preds = np.log(preds) / temperature
    exp_preds = np.exp(preds)
    preds = exp_preds / np.sum(exp_preds)
    probas = np.random.multinomial(1, preds, 1)
    return np.argmax(probas)


def on_epoch_end(epoch, not_used=None):
    print()
    print('----- Generating text after Epoch:', epoch)
    start_index = random.randint(0, len(text) - maxlen - 1)
    for diversity in [0.2, 0.5, 1.0, 1.2]:
        print('----- diversity:', diversity)
        generated = ''
        sentence = text[start_index:start_index + maxlen:None]
        generated = generated + sentence
        print('----- Generating with seed:', sentence)
        sys.stdout.write(generated)
        for i in range(400):
            x_pred = np.zeros([1, maxlen, len(chars)])
            for [t, char] in [j for j in enumerate(sentence)]:
                x_pred[0][t][char_indices[char]] = 1
            preds = first(model.predict(x_pred, verbose=0))
            print('** preds=', preds)
            next_index = sample(preds, diversity)
            next_char = indices_char[next_index]
            sentence = sentence[1:None:None] + next_char
            sys.stdout.write(next_char)
            sys.stdout.flush()
        print()


print_callback = LambdaCallback(on_epoch_end=on_epoch_end)
model.fit(x, y, batch_size=128, epochs=60, callbacks=[print_callback])

