from flask import request
from flask_restful import reqparse, Resource, fields, marshal

from App.ext import db
from App.apis.api_constant import data_response
from App.models import Puzzle

puzzle_init = reqparse.RequestParser()
puzzle_init.add_argument("username", type=str, help='请输入学号', required=True, location=['json'])

puzzle_time = puzzle_init.copy()
puzzle_time.add_argument("time", type=str, help='请输入是时间', required=True, location=['json'])

puzzle_rank = puzzle_init.copy()
puzzle_rank.add_argument("rank", type=str, help='请输入积分', required=True, location=['json'])

user_fields = {
    "username": fields.String,
    "rank": fields.Integer
}

multi_user_fields = {
    "num": fields.String,
    "msg": fields.String,
    "data": fields.List(fields.Nested(user_fields))
}

time_fields = {
    "username": fields.String,
    "time_a": fields.Integer,
    "time_b": fields.Integer,
    "time_c": fields.Integer
}

multi_time_fields = {
    "num": fields.String,
    "msg": fields.String,
    "data": fields.List(fields.Nested(time_fields))
}


class RankResource(Resource):
    def post(self):
        args = puzzle_rank.parse_args()
        username = args.get("username")
        ranks = args.get("rank")
        if Puzzle.query.filter(Puzzle.username.__eq__(username)).first() is None:
            user = Puzzle()
            user.username = username
            db.session.add(user)
            db.session.commit()
            print("ok")
        try:
            old_user = Puzzle.query.filter(Puzzle.username.__eq__(username)).first()
            old_user.rank = int(old_user.rank) + int(ranks)
            db.session.add(old_user)
            db.session.commit()
            return data_response(1, "success", old_user.rank, 200)
        except Exception as e:
            return data_response(0, "error", e, 500)

    def get(self):
        num = Puzzle.query.count()
        user_info = Puzzle.query.order_by(Puzzle.rank.desc()).all()
        msg = {
            "num": num,
            "msg": "获取成功",
            "data": user_info
        }
        return marshal(msg, multi_user_fields)


class TimeResource(Resource):
    def post(self):
        args = puzzle_time.parse_args()
        username = args.get("username")
        type = request.headers.get("type")
        time = args.get("time")
        if Puzzle.query.filter(Puzzle.username.__eq__(username)).first() is None:
            user = Puzzle()
            user.username = username
            db.session.add(user)
            db.session.commit()
        old_user = Puzzle.query.filter(Puzzle.username.__eq__(username)).first()
        try:
            if type == 'A':
                if int(old_user.time_a) > int(time):
                    old_user.time_a = int(time)
            if type == 'B':
                if int(old_user.time_b) > int(time):
                    old_user.time_b = int(time)
            if type == 'C':
                if int(old_user.time_c) > int(time):
                    old_user.time_c = int(time)
            db.session.add(old_user)
            db.session.commit()
            return data_response(1, "success", username, 201)

        except Exception as e:
            return data_response(0, "error", e, 500)

    def get(self):
        num = Puzzle.query.count()
        user_info = Puzzle.query.all()
        msg = {
            "num": num,
            "msg": "success",
            "data": user_info
        }
        return marshal(msg, multi_time_fields)


class PuzzleUser(Resource):
    def get(self):
        try:
            args = puzzle_init.add_argument()
            username = args.get("username")
            if Puzzle.query.filter(Puzzle.username.__eq__(username)).first() is None:
                user = Puzzle()
                user.username = username
                db.session.add(user)
                db.session.commit()
            else:
                pass
            return data_response(1, "登录成功", username, 200)

        except Exception as e:
            return data_response(0, "初始化失败", e, 500)
