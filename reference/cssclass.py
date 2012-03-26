#!/usr/bin/env python
"""
Generates CSS rules for StateFace using state abbreviations rather than codes.

Pass it the .json file containing the mapping between state abbrevations
and StateFace code letters.
"""
from string import Template
import sys

try:
    import json
except ImportError:
    import simplejson as json

CLASS_PREFIX = 'stateface'

CSS = Template("""\
.$prefix:before {
    font-family: StateFaceRegular;
    margin-right: 5px;
}

.$prefix-replace {
    text-indent: -999em;
    display: inline-block;
    position: relative;
    min-width: 1em;
}

.$prefix-replace:before {
    position: absolute;
    left: 0;
    top: 0;
    text-indent: 0;
}
""").substitute(prefix=CLASS_PREFIX)

STATE_RULE = Template("""\
.$prefix-$abbrev:before {
    content: "$code";
}
""").safe_substitute(prefix=CLASS_PREFIX)

def make_state_rules(state_mapping):
    rules = []

    for abbrev, code in sorted(state_mapping.iteritems()):
        rule = Template(STATE_RULE).substitute(
            abbrev=abbrev.lower(),
            code=code
        )
        rules.append(rule)

    return '\n'.join(rules)

def main():
    try:
        f = open(sys.argv[1])
    except IndexError:
        f = sys.stdin
    state_mapping = json.load(f)
    print CSS
    print make_state_rules(state_mapping)

if __name__ == '__main__':
    sys.exit(main())
