# -*- encoding:utf8 -*-
import sys
import os
import requests

try:
    import slack
    from db import DB
except Exception:
    sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))
    from common import slack
    from common.db import DB


def lambda_handler(event, context):
    pass


if __name__ == "__main__":
    param = {
        'env': 'local', 
        'value': 'test parameter'
    }
    
    lambda_handler(param, None)
