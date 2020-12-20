import hy.macros
hy.macros.require('hy.contrib.walk', None, assignments=[['let', 'let']],
    prefix='')
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
    _hyx_letXUffffX1 = {}
    _hyx_letXUffffX1['tokens'] = tokenize_keep_uris(s.replace('{', ' { ').
        replace('}', ' } ').replace('.', ' . '))
    _hyx_letXUffffX1['ret'] = StringIO()
    for token in _hyx_letXUffffX1['tokens']:
        (_hyx_letXUffffX1['ret'].write(red(token)) if token[0] == '?' else 
            _hyx_letXUffffX1['ret'].write(blue(token)) if token in ['where',
            'select', 'distinct', 'option', 'filter', 'FILTER', 'OPTION',
            'DISTINCT', 'SELECT', 'WHERE'] else _hyx_letXUffffX1['ret'].
            write(bold(token)) if token[0] == '<' else _hyx_letXUffffX1[
            'ret'].write(token)) if len(token) > 0 else None
        _hyx_letXUffffX1['ret'].write(' ') if not token == '?' else None
    _hyx_letXUffffX1['ret'].seek(0)
    return _hyx_letXUffffX1['ret'].read()

