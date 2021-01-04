from flask_restful import Api

from App.apis.phone_book_api import phoneBook, phoneBooks, CategoryResource, SearchUser

api = Api()


def init_api(app):
    api.init_app(app)

# 学生通讯录
api.add_resource(phoneBook, '/phone_book/<id>')  # 删改查 单个
api.add_resource(phoneBooks, '/phone_books')  # 增单个 获取全部
api.add_resource(CategoryResource, '/phone_category')  # 分类信息
api.add_resource(SearchUser, '/phone_search')  # 用户搜索
