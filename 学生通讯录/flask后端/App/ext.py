
from flask_migrate import Migrate
# from flask_socketio import SocketIO
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
migrate = Migrate()
# socket_io = SocketIO()


def init_ext(app):
    db.init_app(app)
    migrate.init_app(app, db)
#    socket_io.init_app(app)
