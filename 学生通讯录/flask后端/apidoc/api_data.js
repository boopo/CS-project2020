define({ "api": [
  {
    "type": "Delete",
    "url": "/user/<int:id>",
    "title": "",
    "group": "删除用户信息",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "id",
            "description": "<p>页数</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example",
          "content": "https://www.lvyingzhao.cn/user/3      #删除id为3的用户信息",
          "type": "args"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"msg\": \"delete ok\",\n    \"data\": 3\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "type": "String",
            "optional": false,
            "field": "message",
            "description": "<p>失败</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n   \"msg\" : \"获取失败,数据添加或查询出现错误\"，\n   \"data\" :\"Null\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "删除用户信息",
    "name": "DeleteUserIntId"
  },
  {
    "type": "Delete",
    "url": "/admin/feedback/<int:id>",
    "title": "",
    "group": "删除用户反馈",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "id",
            "description": "<p>页数</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example",
          "content": "https://api.kxz.atcumt/admin/feedback/3      #删除id为3的反馈信息",
          "type": "args"
        }
      ]
    },
    "header": {
      "fields": {
        "Header": [
          {
            "group": "Header",
            "type": "String",
            "optional": false,
            "field": "token",
            "description": "<p>用户授权token</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"msg\": \"delete ok\",\n    \"data\": 3\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "type": "String",
            "optional": false,
            "field": "message",
            "description": "<p>鉴权失败</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n   \"msg\" : \"获取失败,数据添加或查询出现错误\"，\n   \"data\" :\"Null\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "删除用户反馈",
    "name": "DeleteAdminFeedbackIntId"
  },
  {
    "type": "Post",
    "url": "/admin/version/",
    "title": "",
    "group": "发布新版本（慎用，请增加本地学号验证，仅08192988（牟）可以）",
    "header": {
      "fields": {
        "Header": [
          {
            "group": "Header",
            "type": "String",
            "optional": false,
            "field": "token",
            "description": "<p>用户授权token（super root可用） #版本更新</p>"
          }
        ]
      }
    },
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "version",
            "description": "<p>版本号</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "url",
            "description": "<p>apk地址</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "description",
            "description": "<p>新版本描述</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "isForceUpgrade",
            "description": "<p>是否强制更新</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example",
          "content": "\n  {\n    \"version\": \"0.7.14\",\n    \"url\": \"https://cumt-kxz-1300931999.cos.ap-nanjing.myqcloud.com/CUMT-KXZ/FlyingKXZ.apk\",\n    \"description\": \"自定义壁纸\",\n    \"isForceUpgrade\": \"True\"\n}",
          "type": "json"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n            \"status\": 200,\n            \"msg\": \"ok\",\n            \"data\": 'https://cumt-kxz-1300931999.cos.ap-nanjing.myqcloud.com/CUMT-KXZ/FlyingKXZ.apk'\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "type": "String",
            "optional": false,
            "field": "message",
            "description": "<p>鉴权失败</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"msg\": \"method not allowed\"\n\n}\n\n {\n        \"status\": 404,\n        \"check\": False,\n        \"isForceUpgrade\": False,\n        \"description\": \"找不到资源\",\n        \"apkUrl\": \"https://cumt-kxz-1300931999.cos.ap-nanjing.myqcloud.com/CUMT-KXZ/FlyingKXZ.apk\"\n }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "发布新版本（慎用，请增加本地学号验证，仅08192988（牟）可以）",
    "name": "PostAdminVersion"
  },
  {
    "type": "Get",
    "url": "/admin/page_feedback",
    "title": "",
    "group": "用户反馈",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "page",
            "description": "<p>页数</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "per_page",
            "description": "<p>每页的大小</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example",
          "content": "https://api.kxz.atcumt/admin/page_feedback?page=2&perPage=3",
          "type": "args"
        }
      ]
    },
    "header": {
      "fields": {
        "Header": [
          {
            "group": "Header",
            "type": "String",
            "optional": false,
            "field": "token",
            "description": "<p>用户授权token</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          },
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "num",
            "description": "<p>用户总数</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"num\": 19,\n    \"msg\": \"ok\",\n    \"data\": [\n        {\n            \"id\": 10,\n            \"data\": \"考试的剩余时间好像差一天。。\"\n        },\n        {\n            \"id\": 11,\n            \"data\": \"nb\"\n        },\n        {\n            \"id\": 12,\n            \"data\": \"针不戳\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "type": "String",
            "optional": false,
            "field": "message",
            "description": "<p>鉴权失败</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n   \"msg\" : \"获取失败,数据添加或查询出现错误\"，\n   \"data\" :\"Null\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "用户反馈",
    "name": "GetAdminPage_feedback"
  },
  {
    "type": "Get",
    "url": "/admin/page_feedback",
    "title": "",
    "group": "用户反馈",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "page",
            "description": "<p>页数</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "per_page",
            "description": "<p>每页的大小</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example",
          "content": "https://api.kxz.atcumt/admin/page_feedback?page=2&perPage=3",
          "type": "args"
        }
      ]
    },
    "header": {
      "fields": {
        "Header": [
          {
            "group": "Header",
            "type": "String",
            "optional": false,
            "field": "token",
            "description": "<p>用户授权token</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          },
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "num",
            "description": "<p>用户总数</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"num\": 19,\n    \"msg\": \"ok\",\n    \"data\": [\n        {\n            \"id\": 10,\n            \"data\": \"考试的剩余时间好像差一天。。\"\n        },\n        {\n            \"id\": 11,\n            \"data\": \"nb\"\n        },\n        {\n            \"id\": 12,\n            \"data\": \"针不戳\"\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "type": "String",
            "optional": false,
            "field": "message",
            "description": "<p>鉴权失败</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n   \"msg\" : \"获取失败,数据添加或查询出现错误\"，\n   \"data\" :\"Null\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "用户反馈",
    "name": "GetAdminPage_feedback"
  },
  {
    "type": "Get",
    "url": "/admin/page_amount",
    "title": "",
    "group": "用户总数",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "page",
            "description": "<p>页数</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "per_page",
            "description": "<p>每页的大小</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example",
          "content": "https://api.kxz.atcumt/admin/page_amount?page=2&perPage=20",
          "type": "args"
        }
      ]
    },
    "header": {
      "fields": {
        "Header": [
          {
            "group": "Header",
            "type": "String",
            "optional": false,
            "field": "token",
            "description": "<p>用户授权token</p>"
          }
        ]
      }
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          },
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "num",
            "description": "<p>用户总数</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"num\": 706,\n    \"msg\": \"ok\",\n    \"data\": [\n        {\n            \"username\": \"08182994\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"17195021\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"06181987\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"08183098\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"05191575\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"17195409\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"12203739\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"15194764\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"17194986\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"06182166\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"15194763\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"02190792\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"08192926\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"06172276\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"06182137\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"07203707\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"09204147\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"08183059\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"01205008\",\n            \"permission\": 2\n        },\n        {\n            \"username\": \"08182932\",\n            \"permission\": 2\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "type": "String",
            "optional": false,
            "field": "message",
            "description": "<p>鉴权失败</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n   \"msg\" : \"获取失败,数据添加或查询出现错误\"，\n   \"data\" :\"Null\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "用户总数",
    "name": "GetAdminPage_amount"
  },
  {
    "type": "Get",
    "url": "/page_amount",
    "title": "",
    "group": "用户版本信息",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "page",
            "description": "<p>页数</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "perPage",
            "description": "<p>每页的大小</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example",
          "content": "https://www.lvyingzhao.cn/per_amount?page=2&perPage=3",
          "type": "args"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          },
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "num",
            "description": "<p>用户总数</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"num\": 1,\n    \"msg\": \"ok\",\n    \"data\": [\n        {\n            \"id\": 8,\n            \"username\": \"08193109\",\n            \"platform\": \"android\",\n            \"version\": \"0.7.14\",\n            \"count\": 2\n        }\n    ]\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n   \"msg\" : \"获取失败,数据添加或查询出现错误\"，\n   \"data\" :\"Null\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "用户版本信息",
    "name": "GetPage_amount"
  },
  {
    "type": "Get",
    "url": "/version",
    "title": "",
    "group": "用户版本信息分类",
    "parameter": {
      "examples": [
        {
          "title": "Request-Example",
          "content": "https://www.lvyingzhao.cn/version",
          "type": "args"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          },
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "num",
            "description": "<p>用户总数</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"num\": 562,\n    \"mag\": \"ok\",\n    \"data\": {\n        \"0.7.1\": 150,\n        \"0.7.14\": 373\n    }\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n      \"num\": '',\n      \"msg\": \"sql error!\",\n      \"data\": ''\n }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "用户版本信息分类",
    "name": "GetVersion"
  },
  {
    "type": "Get",
    "url": "/type",
    "title": "",
    "group": "用户设备信息分类",
    "parameter": {
      "examples": [
        {
          "title": "Request-Example",
          "content": "https://www.lvyingzhao.cn/type",
          "type": "args"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          },
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "num",
            "description": "<p>用户总数</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"num\": 562,\n    \"mag\": \"ok\",\n    \"data\": {\n        \"android\": 411,\n        \"ios\": 151\n    }\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n      \"num\": '',\n      \"msg\": \"sql error!\",\n      \"data\": ''\n }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "用户设备信息分类",
    "name": "GetType"
  },
  {
    "type": "Post",
    "url": "/jwxt/login",
    "title": "",
    "group": "登录",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "username",
            "description": "<p>学号</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "password",
            "description": "<p>密码</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example",
          "content": "{\n    'username':'08193109',\n    'password':'XXXXXXXX'\n}",
          "type": "json"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "code",
            "description": "<p>0</p>"
          },
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>登录成功</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据（姓名，年纪，token）</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"code\": 0,\n    \"data\": {\n        \"name\": \"吕迎朝\",\n        \"college\": \"计算机科学与技术学院\",\n        \"classname\": \"数据科学与大数据技术2019-02班\",\n        \"token\": \"eyJ0eXAiQiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MDU3guMjE0OTM3LCJkYXRhIjp7InVzZXJuYW1lIjoiMDgxOTMxMDkiLCJwYXNzZCI6IjAzMDAx9fQ.Uoh8wj49SdMeE8t3f_l6r4huFg1-NqHEo3nPkDLd4\"\n    },\n    \"msg\": \"登录成功\"\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "type": "String",
            "optional": false,
            "field": "code",
            "description": "<p>1</p>"
          },
          {
            "group": "Error 4xx",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>登录失败，请检查你的用户名或密码</p>"
          },
          {
            "group": "Error 4xx",
            "type": "Integer",
            "optional": false,
            "field": "data",
            "description": "<p>null</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"code\": 1,\n    \"data\": \"null\",\n    \"msg\": \"登录失败,请检查你的用户名或密码！\"\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "登录",
    "name": "PostJwxtLogin"
  },
  {
    "type": "Get",
    "url": "/admin/version/",
    "title": "",
    "group": "获取版本信息",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "version",
            "description": "<p>app当前版本</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Request-Example",
          "content": "https://api.kxz.atcumt/admin/version?version=0.9.1.2      #发送当前版本，获取最新版本",
          "type": "args"
        }
      ]
    },
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "msg",
            "description": "<p>ok</p>"
          },
          {
            "group": "Success 200",
            "type": "string",
            "optional": false,
            "field": "data",
            "description": "<p>返回数据</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Response-Example",
          "content": "\n{\n    \"status\": 200,\n    \"check\": true,\n    \"isForceUpgrade\": false,\n    \"description\": \"矿小助0.7.14重要更新内容：\\n【全新外观】界面焕新，并可以自定义全局背景图，外观党福利。\\n【内置更新】为安卓用户内置了更新渠道，下载安装一条龙。\\n\\n细节更新：\\n【课表卡片】重新进行了色彩搭配\\n【考试倒计时】取消“考试倒计时”标题，取消“已结束”的倒计时卡片，倒计时为0时显示“今天”（附彩蛋）\\n【成绩自动查询】自动查询当前学年学期成绩\\n\\n2020.12.10\",\n    \"apkUrl\": \"https://cumt-kxz-1300931999.cos.ap-nanjing.myqcloud.com/CUMT-KXZ/0.7.14.apk\"\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "examples": [
        {
          "title": "Response-Example",
          "content": "{\n                \"status\": 404,\n                \"check\": False,\n                \"isForceUpgrade\": False,\n                \"description\": \"找不到资源\",\n                \"apkUrl\": \"\"\n  }",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "src/file1.js",
    "groupTitle": "获取版本信息",
    "name": "GetAdminVersion"
  }
] });
