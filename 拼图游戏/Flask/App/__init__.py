from flask import Flask
from App.apis import init_api
from App.ext import init_ext, db
from App.settings import envs
from App.views import init_view


def create_app(env):
    app = Flask(__name__)

    #    数据库+驱动：//用户名：密码@主机：端口/具体库
    # app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///sqlite.db"
    # app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    # 来个密钥
    app.config['SECRET_KEY'] = 'life++'

    # 初始化配置
    app.config.from_object(envs.get(env))
    # 初始化API
    init_api(app)
    # 初始化路由
    init_view(app)
    # 初始化第三方扩展
    init_ext(app)

    return app
