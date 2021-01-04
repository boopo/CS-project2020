def get_db_uri(dbinfo):
    engine = dbinfo.get('ENGINE')
    driver = dbinfo.get('DRIVER')
    user = dbinfo.get('USER')
    password = dbinfo.get('PASSWORD')
    host = dbinfo.get('HOST')
    port = dbinfo.get('PORT')
    name = dbinfo.get('NAME')
    return "{}+{}://{}:{}@{}:{}/{}".format(engine, driver, user, password, host, port, name)


class Config:
    TESTING = False
    DEBUG = False
    SQLALCHEMY_TRACK_MODIFICATIONS = False


class DevelopConfig(Config):
    DEBUG = True

    dbinfo = {
        "ENGINE": "mysql",
        "DRIVER": "pymysql",
        "USER": "root",
        "PASSWORD": "k1333csn.",
        "HOST": "你的数据库地址",
        "PORT": '你的数据库端口号',
        "NAME": "你的数据库名字"
    }
    SQLALCHEMY_DATABASE_URI = get_db_uri(dbinfo)


    SECRET_KEY = 'socketio996'

    #   REDIS_URL = "redis://@localhost:6379/0"


class TestingConfig(Config):
    TESTING = True

      dbinfo = {
        "ENGINE": "mysql",
        "DRIVER": "pymysql",
        "USER": "root",
        "PASSWORD": "k1333csn.",
        "HOST": "你的数据库地址",
        "PORT": '你的数据库端口号',
        "NAME": "你的数据库名字"
    }

    SQLALCHEMY_DATABASE_URI = get_db_uri(dbinfo)





class StagingConfig(Config):
       dbinfo = {
        "ENGINE": "mysql",
        "DRIVER": "pymysql",
        "USER": "root",
        "PASSWORD": "k1333csn.",
        "HOST": "你的数据库地址",
        "PORT": '你的数据库端口号',
        "NAME": "你的数据库名字"
    }

    SQLALCHEMY_DATABASE_URI = get_db_uri(dbinfo)




class ProductConfig(Config):
    dbinfo = {
        "ENGINE": "mysql",
        "DRIVER": "pymysql",
        "USER": "root",
        "PASSWORD": "k1333csn.",
        "HOST": "你的数据库地址",
        "PORT": '你的数据库端口号',
        "NAME": "你的数据库名字"
    }

    SQLALCHEMY_DATABASE_URI = get_db_uri(dbinfo)


envs = {
    "develop": DevelopConfig,
    "testing": TestingConfig,
    "staging": StagingConfig,
    "product": ProductConfig,
    "default": DevelopConfig
}
