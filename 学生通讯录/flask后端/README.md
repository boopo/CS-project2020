<h1>学生通讯录 后端
</h1>



本地启动方式:

       pip install - r requirements.txt

       python manage.py runserver -r -d



Linux：
           
           
        先配置nginx反向代理

        gunicorn -w 4 -b 127.0.0.1:22222 manage:app

