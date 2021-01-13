from flask_restful import Api

from App.apis.addpic_api import RankResource, TimeResource
from App.apis.phone_book_api import phoneBook, phoneBooks, CategoryResource, SearchUser
from App.apis.user_api import UserInfoResource, CountResource, PageCountResource, UserPreInfoResource, \
    PerNumberResource, checkVersionResource

api = Api()


def init_api(app):
    api.init_app(app)


api.add_resource(UserPreInfoResource, '/action')  # 收集信息
api.add_resource(UserInfoResource, '/user/<int:id>')  # 查看单个用户信息，增删
api.add_resource(CountResource, '/amount')  # 用户总数
api.add_resource(PageCountResource, '/page_amount')  # 分页查询
api.add_resource(PerNumberResource, '/type')  # 用户类型
api.add_resource(checkVersionResource, '/version')  # 版本信息统计

# 学生通讯录
api.add_resource(phoneBook, '/phone_book/<id>')  # 删改查 单个
api.add_resource(phoneBooks, '/phone_books')  # 增单个 获取全部
api.add_resource(CategoryResource, '/phone_category')  # 分类信息
api.add_resource(SearchUser, '/phone_search')  # 用户搜索

# 拼图游戏
api.add_resource(RankResource, '/puzzle/rank')
api.add_resource(TimeResource, '/puzzle/time')
