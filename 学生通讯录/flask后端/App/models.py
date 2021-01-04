from App.ext import db


class UserInfo(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(32), unique=True, index=True)
    platform = db.Column(db.String(128), index=True)
    version = db.Column(db.String(64))
    count = db.Column(db.Integer)


class Post(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    content = db.Column(db.String(256))


class VersionCount(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    version = db.Column(db.String(64))
    user_count = db.Column(db.Integer)


class StuInfo(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    stuNumber = db.Column(db.String(32), unique=True)
    name = db.Column(db.String(64))
    sex = db.Column(db.String(16))
    age = db.Column(db.String(256))
    birthday = db.Column(db.String(64))
    address = db.Column(db.String(512))
    qq = db.Column(db.String(32))
    mail = db.Column(db.String(128))
    college = db.Column(db.String(256))
    belong = db.Column(db.String(256))
    phone = db.Column(db.String(64))
    remarks = db.Column(db.String(64))


class Category(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    group = db.Column(db.String(32), unique=True)