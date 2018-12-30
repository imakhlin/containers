#!/usr/bin/python

import json
import requests
import sys
import getopt


def _get_session_token(v3io_url, username, password):
    body = {
        'data':
            {
                'type': 'session',
                'attributes':
                    {
                        'username': username,
                        'password': password,
                        'plane': 'data',
                        'interface_kind': 'web'
                    }
            }
    }

    try:
        res = requests.post('{}/api/sessions'.format(v3io_url), data=json.dumps(body),
                            headers={'Content-Type': 'application/json'})
        res.raise_for_status()

        return json.loads(res.content)['data']['id']

    except requests.exceptions.HTTPError as err:
        print err
        sys.exit(1)
    except KeyError as key_error:
        print('No such key: [{}]'.format(key_error))
        sys.exit(2)
    except AttributeError as attr_error:
        print(
            'Unable to get session token for {}. Check username and password.\nCause: {}'.format(username, attr_error))
        sys.exit(3)
    except requests.exceptions.RequestException as e:
        print('An unexpected exception caught.\nException: {}'.format(e))
        sys.exit(4)


def print_usage_and_exit():
    print 'Usage: python get_session_token.py -s <V3IO platform service URL> -u <username> -p <password>'
    sys.exit(5)


def main(argv):
    platform_url = ''  # type: str
    username = ''  # type: str
    password = ''  # type: str

    try:
        opts, args = getopt.getopt(argv, "s:u:p:", ["platfrom-url=", "username=", "password="])
    except getopt.GetoptError:
        print_usage_and_exit()
        sys.exit(5)

    for opt, arg in opts:
        if opt in ("-s", "--platfrom-url"):
            platform_url = arg
        elif opt in ("-u", "--username"):
            username = arg
        elif opt in ("-p", "--password"):
            password = arg

    # Validate input
    if '' in (platform_url, username, password):
        print_usage_and_exit()

    # Invoke
    token = _get_session_token(platform_url, username, password)
    print '\nSession token for user \'{}\' is:\n{}'.format(username, token)


if __name__ == "__main__":
    main(sys.argv[1:])

