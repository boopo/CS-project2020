

class ResponseCode:
    SUCCESS = 200
    SQL_OK = 201
    ERROR = 400
    SQL_ERROR = 400
    NOTFOUND = 404
    MESSAGE = 'ok'


def data_response(num=1, msg='ok', data='', status=200):
    return {
        'num': num,
        'msg': msg,
        'data': data
    }, status

