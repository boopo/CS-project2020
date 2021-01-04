from flask_restful import Resource, abort, fields, marshal, reqparse

from App.ext import db
from App.apis.api_constant import data_response
from App.models import StuInfo, Category

phone_book = reqparse.RequestParser()
phone_book.add_argument("stuNumber", type=str, help='请输入学号', required=True, location=['json'])
phone_book.add_argument("name", type=str, help='请输入姓名', required=True, location=['json'])
phone_book.add_argument("sex", type=str, help='请输入性别', required=True, location=['json'])
phone_book.add_argument("age", type=str, help='请输入年龄', required=True, location=['json'])
phone_book.add_argument("birthday", type=str, help='请输入生日', required=True, location=['json'])
phone_book.add_argument("address", type=str, help='请输入地址', required=True, location=['json'])
phone_book.add_argument("qq", type=str, help='请输入qq号', required=True, location=['json'])
phone_book.add_argument("mail", type=str, help='请输入邮箱', required=True, location=['json'])
phone_book.add_argument("college", type=str, help='请输入专业', required=True, location=['json'])
phone_book.add_argument("belong", type=str, help="please", required=True, location=['json'])
phone_book.add_argument("phone", type=str, help="请输入电话", required=True, location=['json'])
phone_book.add_argument("remarks", type=str, help="请输入备注", required=True, location=['json'])

edit_book = reqparse.RequestParser()
edit_book.add_argument("id", type=str, help='请输入编号', required=True, location=['args'])

group_book = reqparse.RequestParser()
group_book.add_argument("belong", type=str, help='请输入分组', required=True, location=['json'])

ac_book = group_book.copy()
ac_book.add_argument("id", type=str, help='请输入id',  required=True, location=['json'])

search_name = reqparse.RequestParser()
search_name.add_argument("name", type=str, help='请输入姓名', required=True, location=['args'])

phone_fields = {
    "id": fields.Integer,
    "stuNumber": fields.String,
    "name": fields.String,
    "sex": fields.String,
    "age": fields.String,
    "birthday": fields.String,
    "address": fields.String,
    "qq": fields.String,
    "mail": fields.String,
    "college": fields.String,
    "belong": fields.String,
    "phone": fields.String,
    "remarks": fields.String
}

single_phone_fields = {
    "num": fields.Integer,
    "msg": fields.String,
    "data": fields.Nested(phone_fields)
}

multi_phone_fields = {
    "num": fields.Integer,
    "msg": fields.String,
    "data": fields.List(fields.Nested(phone_fields))
}


class phoneBook(Resource):
    def get(self, id):
        stu_info = StuInfo.query.get(id)
        if not stu_info:
            abort(404)
        msg = {
            "num": 1,
            "msg": "获取成功",
            "data": stu_info
        }
        return marshal(msg, single_phone_fields)

    def delete(self, id):
        try:
            p_book = StuInfo.query.get(id)
            db.session.delete(p_book)
            db.session.commit()
            return data_response(1, "删除成功", id, 201)
        except Exception as e:
            return data_response(0, '删除失败', id, 500)

    def put(self, id):
        try:
            args = phone_book.parse_args()
            p_book = StuInfo.query.get(id)
            p_book.stuNumber = args.get("stuNumber")
            p_book.name = args.get("name")
            p_book.sex = args.get("sex")
            p_book.age = args.get("age")
            p_book.birthday = args.get("birthday")
            p_book.address = args.get("address")
            p_book.qq = args.get("qq")
            p_book.mail = args.get("mail")
            p_book.college = args.get("college")
            p_book.belong = args.get("belong")
            p_book.phone = args.get("phone")
            p_book.remarks = args.get("remarks")
            db.session.add(p_book)
            db.session.commit()
            return data_response(1, '修改成功', id, 201)
        except Exception as e:
            return data_response(1, e, id, 500)


class phoneBooks(Resource):
    def get(self):
        stu_info = StuInfo().query.all()
        num = StuInfo.query.count()
        if not StuInfo:
            abort(404)
        msg = {
            "num": num,
            "msg": "获取成功",
            "data": stu_info
        }
        return marshal(msg, multi_phone_fields)

    def post(self):
        args = phone_book.parse_args()
        p_book = StuInfo()
        p_book.stuNumber = args.get("stuNumber")
        p_book.name = args.get("name")
        p_book.sex = args.get("sex")
        p_book.age = args.get("age")
        p_book.birthday = args.get("birthday")
        p_book.address = args.get("address")
        p_book.qq = args.get("qq")
        p_book.mail = args.get("mail")
        p_book.college = args.get("college")
        p_book.belong = args.get("belong")
        p_book.phone = args.get("phone")
        p_book.remarks = args.get("remarks")
        try:
            db.session.add(p_book)
            db.session.commit()
            msg = {
                "num": 1,
                "msg": "添加成功",
                "data": p_book
            }
            return marshal(msg, single_phone_fields), 201
        except Exception as e:
            return data_response(0, e, 'null', 500)


class CategoryResource(Resource):
    def post(self):
        args = group_book.parse_args()
        group = args.get("belong")
        try:
            category = Category()
            category.group = group
            db.session.add(category)
            db.session.commit()
            return data_response(1, '分组添加成功', group, 201)
        except Exception as e:
            return data_response(0, e, group, 500)

    def delete(self):
        args = group_book.parse_args()
        group = args.get("belong")
        try:
            category = Category.query.filter(Category.group.__eq__(group)).first()
            belong_list = StuInfo.query.filter(StuInfo.belong.__eq__(group)).all()
            for a in belong_list:
                a.belong = 'normal'
                db.session.add(a)
                db.session.commit()
            db.session.delete(category)
            db.session.commit()
            return data_response(1, 'ok', '分类已删除, 变为normal', 201)

        except Exception as e:
            return data_response(1, e, 'error', 500)

    def get(self):
        try:
            category_list = Category.query.all()
            category_num = Category.query.count()
            d1 = {}
            d2 = {}
            d3 = {"userCategoryCount": category_num}
            d4 = {}
            ll = []
            for a in category_list:
                stu_l1 = StuInfo.query.filter(StuInfo.belong.__eq__(a.group)).all()
                num = StuInfo.query.filter(StuInfo.belong.__eq__(a.group)).count()
                l1 = []
                d2.update({a.group: num})
                d5 = {}
                for b in stu_l1:
                    l1.append(
                        {
                            "id": b.id,
                            "stuNumber": b.stuNumber,
                            "name": b.name,
                            "sex": b.sex,
                            "age": b.age,
                            "birthday": b.birthday,
                            "address": b.address,
                            "qq": b.qq,
                            "mail": b.mail,
                            "college": b.college,
                            "belong": b.belong,
                            "phone": b.phone,
                            "remarks": b.remarks
                        }
                    )
                d5.update({"groupName": a.group})
                d5.update({"userInfo": l1})
                ll.append(d5)

            d4.update(d3)
            d4.update({"userCount": d2})
            d4.update({"userList": ll})
            return data_response(1, "ok", d4, 200)

        except Exception as e:
            return data_response(1, e, 'error', 500)

    def put(self):
        try:
            args = ac_book.parse_args()
            g_id = args.get("id")
            group = args.get("belong")
            use = StuInfo.query.get(g_id)
            use.belong = group
            db.session.add(use)
            db.session.commit()
            return data_response(1, "修改成功", g_id+'现在在'+group, 201)

        except Exception as e:
            return data_response(1, e, 'error', 500)


class SearchUser(Resource):
    def get(self):
        args = search_name.parse_args()
        name = args.get('name')
        try:
            name = StuInfo.query.filter(StuInfo.name.ilike('%'+name+'%')).all()
            i = 0   # count会报错。。。
            for a in name:
                i = i+1
           # name_count = StuInfo.query.filter(StuInfo.name.ilike('%'+name+'%')).count()

            msg = {
                "num": i,
                "msg": "查询成功",
                "data": name
            }
            return marshal(msg, multi_phone_fields)
        except Exception as e:
            return data_response(0, e, "error", 500)
