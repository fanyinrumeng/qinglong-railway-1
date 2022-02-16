# Railway-docker-zhenxun

使用 railway 一键部署 zhenxun_bot

## 一、注册 railway 账号和 ngrok 账号

[railway](https://railway.app/)

[ngrok](https://dashboard.ngrok.com/auth)

## 二、部署

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/AkashiCoin/Railway-docker-zhenxun&envs=NGROK_TOKEN)

1、点击上方的按钮，如果你未注册，则可以直接使用 Github 账号登录；若已登录，就会提醒你根据此模板在 github 中`新建项目`

2、在 NGROK_TOKEN 中输入你在 [ngrok](https://dashboard.ngrok.com/auth)得到的 token

3、在 railway 中点击`Add Plugin`添加 `PostgreSQL` 数据库

4、回到自己的 github 的 `Railway-docker-zhenxun` 项目中，进行一次 `commit`

5、进入 [ngrok_status](https://dashboard.ngrok.com/endpoints/status) 可看到 ssh 连接地址和端口

6、默认账号: `root` 密码: `akashi520`
