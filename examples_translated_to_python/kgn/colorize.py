from io import StringIO


def blue(s):
    return '{}{}{}'.format('\x1b[94m', s, '\x1b[0m')


def red(s):
    return '{}{}{}'.format('\x1b[91m', s, '\x1b[0m')


def green(s):
    return '{}{}{}'.format('\x1b[92m', s, '\x1b[0m')


def pink(s):
    return '{}{}{}'.format('\x1b[95m', s, '\x1b[0m')


def bold(s):
    return '{}{}{}'.format('\x1b[1m', s, '\x1b[0m')


def tokenize_keep_uris(s):
    return s.split()


def colorize_sparql(s):
    tokens = tokenize_keep_uris(s.replace('{', ' { ').replace('}', ' } ').
        replace('.', ' . '))
    ret = StringIO()
    for token in tokens:
        (ret.write(red(token)) if token[0] == '?' else ret.write(blue(token
            )) if token in ['where', 'select', 'distinct', 'option',
            'filter', 'FILTER', 'OPTION', 'DISTINCT', 'SELECT', 'WHERE'] else
            ret.write(bold(token)) if token[0] == '<' else ret.write(token)
            ) if len(token) > 0 else None
        ret.write(' ') if not token == '?' else None
    ret.seek(0)
    return ret.read()

