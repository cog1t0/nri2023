# Rails7の環境をherokuにパパッと作るためのテンプレート

## 前提
[dip](https://github.com/bibendi/dip)のインストール
herokuのアカウント作成、設定等の準備（無料版無くなってます。[月5＄からの課金が必要](https://jp.heroku.com/pricing)）(無料のホスティングを求めて放浪するのは疲れたんだ...)

## ローカルの準備

### このソースコードをDLして、自分の別のリポジトリとして登録しておく

### プロジェクトの新規作成
```
dip rails new . --force --database=postgresql
docker-compose build --no-cache	
```

### DB作成
```
dip rails db:create
dip rails db:migrate
```

### database.ymlの書き換え
```
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: db
  username: postgres
  password: password

development:
  <<: *default
  database: myapp_development

test:
  <<: *default
  database: myapp_test

production:
  <<: *default
  database: myapp_production
```

### サーバー起動
```
docker-compose up
```

## herokuにデプロイ
[手順](https://devcenter.heroku.com/ja/articles/build-docker-images-heroku-yml)

# herokuよく使うコマンド
## deploy
```
heroku container:push web -a myapp && heroku container:release web -a myapp
```
をdipコマンドにしました
```
dip deploy
```

## コマンド実行
```
heroku run bash
```

## check log
```
heroku logs --tail
```
* ...


## access db
```
 heroku pg:psql
```

## reset db
```
heroku pg:reset -a myapp
heroku run rails db:migrate
```

