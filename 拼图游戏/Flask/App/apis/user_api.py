from flask_restful import Resource, abort, fields, marshal, reqparse

from App.ext import db
from App.models import UserInfo, Post, VersionCount

parse_user = reqparse.RequestParser()
parse_user.add_argument("username", type=str, help='请输入用户名', required=True, location=['args'])
parse_user.add_argument("platform", type=str, help='请输入平台信息', required=True, location=['args'])
parse_user.add_argument("version", type=str, help='请输入版本信息', required=True, location=['args'])

parse_paginate = reqparse.RequestParser()
parse_paginate.add_argument("page", type=str, help='请输入页码', required=True, location=['args'])
parse_paginate.add_argument("perPage", type=str, help='请输入页面大小', required=True, location=['args'])

parse_version = reqparse.RequestParser()
parse_version.add_argument("version", type=str, help='请输入版本信息', required=True, location=['args'])

user_fields = {
    "id": fields.Integer,
    "username": fields.String,
    "platform": fields.String,
    "version": fields.String,
    "count": fields.Integer
}

single_user_fields = {
    "msg": fields.String,
    "data": fields.Nested(user_fields)
}

multi_user_fields = {
    "num": fields.Integer,
    "msg": fields.String,
    "data": fields.List(fields.Nested(user_fields))
}


class UserPreInfoResource(Resource):

    def get(self):
        args = parse_user.parse_args()
        username = args.get('username')
        version = args.get('version')
        platform = args.get('platform')
        try:
            if UserInfo.query.filter(UserInfo.username.__eq__(username)).first() is None:
                newUser = UserInfo()
                newUser.username = username
                newUser.platform = platform
                newUser.version = version
                newUser.count = 1
                db.session.add(newUser)
                db.session.commit()
            else:
                oldUser = UserInfo.query.filter(UserInfo.username.__eq__(username)).first()
                oldUser.count = int(oldUser.count) + 1
                oldUser.platform = platform
                oldUser.version = version
                db.session.add(oldUser)
                db.session.commit()
            return {
                       "msg": "ok",
                       "data": username
                   }, 201
        except Exception as e:
            print(e)
            return {
                       "msg": "sql error!",
                       "data": ''
                   }, 400


class UserInfoResource(Resource):
    def get(self, id):
        try:
            preUser = UserInfo.query.get(id)
            data = {
                "mag": "ok",
                "data": preUser
            }
            return marshal(data, single_user_fields)
        except Exception as e:
            print(e)
            return {
                       "msg": "sql error!",
                       "data": ''
                   }, 400

    def delete(self, id):
        try:
            user = UserInfo.query.get(id)
            db.session.delete(user)
            db.session.commit()
            data = {
                "msg": "delete ok",
                "data": id
            }
            return data, 201
        except Exception as e:
            print(e)
            return {
                       "msg": "sql error!",
                       "data": ''
                   }, 400


class CountResource(Resource):
    def get(self):
        userinfo = UserInfo.query.all()
        num = UserInfo.query.count()
        if not userinfo:
            abort(404)
        msg = {
            "num": num,
            "msg": "ok",
            "data": userinfo
        }
        return marshal(msg, multi_user_fields)


class PageCountResource(Resource):
    def get(self):
        try:
            args = parse_paginate.parse_args()
            page = int(args.get("page"))
            per_page = int(args.get("perPage"))
            user_list = UserInfo.query.offset(per_page * (page - 1)).limit(per_page)
            user_num = UserInfo.query.count()
            msg = {
                "num": user_num,
                "msg": "ok",
                "data": user_list
            }
            return marshal(msg, multi_user_fields)
        except Exception as e:
            print(e)
            return {
                       "num": '',
                       "msg": "sql error!",
                       "data": ''
                   }, 400


class PerNumberResource(Resource):
    def get(self):
        try:
            android = UserInfo.query.filter(UserInfo.platform.__eq__('android')).count()
            ios = UserInfo.query.filter(UserInfo.platform.__eq__('ios')).count()
            return {
                "num": ios + android,
                "msg": "ok",
                "data": {
                    "android": android,
                    "ios": ios
                }
            }
        except Exception as e:
            print(e)
            return {
                       "num": '',
                       "msg": "sql error!",
                       "data": ''
                   }, 400


class checkVersionResource(Resource):
    def get(self):
        try:
            amount_list = VersionCount.query.all()
            d1 = {}
            for a in amount_list:
                num = UserInfo.query.filter(UserInfo.version.__eq__(a.version)).count()
                d1.update({a.version: num})
            count = UserInfo.query.count()
            return{
                "num": count,
                "mag": "ok",
                "data": d1
            }
        except Exception as e:
            print(e)
            return {
                    "msg": "sql error!",
                    "data": ''
            }, 400
