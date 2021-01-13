import os

from flask_migrate import MigrateCommand
from flask_script import Manager
from flask_socketio import SocketIO

from App import create_app

env = os.environ.get("FLASK_ENV") or 'default'

app = create_app(env)

#socketio = SocketIO(app)
manager = Manager(app=app)

manager.add_command('db', MigrateCommand)

if __name__ == '__main__':
     ##socketio.run(app)
    manager.run()
