# 商品管理API

## 使用した技術要素
* java 1.8.0_172
* play 2.6.16
* sbt
* mysql 5.7

## テーブル定義
| カラム名    | 型             |   NULL   |   KEY      |   その他 |
| :--------: | :-----------: | :------: | :--------: | -------- |
| id         | Long          |          |PRI         |          |
| title      | varchar(255)  |  not     |            |          |
| image      | text          |          |            |          |
| introduction | mediumText  |          |            |          |
| price      | integer       |          |            |          |

## 機能一覧
| 機能名        | HTTPメソッド    | リソースパス       |
| :----------:  | :------------: | :----------:    |
| 商品登録       | POST           | /products       |
| 商品更新        | PUT            | /products/:id  |
| 商品削除       | DELETE         | /products/:id   |
| 商品検索       | PUT            | /search/products |

## API設計

#### 認証機能付のAPI
トークン認証機能付のAPIとなっているため、APIにリクエストを送信する際にヘッダーにアクセストークンを持たせる必要がある。  
アクセストークンはログイン時に遷移するページに表示される。  
ヘッダー名は`token`とする。

#### 商品の登録
* Request  
`POST /items`

* Parameters

| Name | Type | Description |
| :--- | :---: | :-----:    |
| title | varchar            | 入力必須/100文字以内 　　　|
| image | text               | imageはBase64方式で入出力　|
| introduction | MEDIUMTEXT  | 500文字以内         　　　|
| price | integer            |                   　　　 |

* Response

````
 {
    "product": {
        "id": 1,
        "title": "りんご",
        "image": "data:image/png;base64,iVBORw0KGgo...以下略",
        "introduction": "美味しい",
        "price": 30
        }
 }
````
* errorResponse
````
{
    "errormessage": [
        "title:商品タイトルを入力してください",
        "introduction:500文字以内で入力してください"
	]
}
````

#### 商品の更新
* Request  
`PUT /products/:id`
* Parameters

| Name | Type | Description |
| :--- | :---: | :-----:    |
| title | varchar            | 入力必須/100文字以内 |
| image | text               | imageはBase64方式で入出力 |
| introduction | MEDIUMTEXT  | 500文字以内         |
| price | integer                |                    |

* Response
````
{
    "product": {
        "id": 1,
        "title": "メロン",
        "image": "data:image/png;base64,iVBORw0KGgo...以下略",
        "introduction": "甘い",
        "price": 30
    }
}
````
* ErrorResponse
````
{
    "errorMessage": "404Error!!"
}
````

#### 商品の削除
* Request  
`DELETE /products/:id`

* Response
````
{
    No body returned for response
}
````

#### 商品の検索
* Request  
`POST /search/products`

* Parameters

| Name | Type | Description |
| :--- | :---: | :-----:    |
| title | varchar            | 商品名で曖昧検索 |

* Response

````
{
"products": [
    {
        "id": 2,
        "title": "りんご",
        "image": "data:image/png;base64,iVBORw0KGgo...以下略",
        "introduction": "美味しい",
        "price": 30
    },
    {
        "id": 3,
        "title": "りんご焼き機",
        "image": "data:image/png;base64,iVBORw0KGgo...以下略",
        "introduction": "いいね",
        "price": 30
    }
]
}

````

## ログイン・ログアウト機能
TwitterのOAuth認証を利用  
application.confにTwitterから取得したAPI　keysを記述することで利用可能  

````
consumerKey = ""
consumerSecretKey = ""
````

#### 機能を利用する際のURLについて
ローカル開発環境で動作確認をする場合はホスト名を「127.0.0.1:9000」とすること、「localhost」はTwitter側が受け付けない

* ログイン画面  
URL  
`/`


* ログイン  
URL  
`/auth`

* ログアウト  
URL  
`/signout`


## 開発環境のセットアップ手順  
###### ※macOSの場合の手順
* HomeBrewインストール
```aidl
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew cleanup
brew tap caskroom/cask
brew tap caskroom/versions
```
* Java8インストール
```aidl
brew cask install java8
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
```
* MySQL, sbt インストール
```aidl
brew install mysql@5.7
brew install sbt
```

* 環境変数設定
```aidl
以下まとめてコピして実行

cat <<EOL >> ~/.bash_profile
echo export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
echo export PATH=$JAVA_HOME/bin:/usr/local/bin:$PATH
echo export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
EOL
source ~/.bash_profile
```

* MySQL の自動起動
```aidl
# 自動起動を無効にする
brew services stop mysql
# 自動起動を有効にする
brew services start mysql
```
* MySQL に root パス無しでログイン出来るように設定
```aidl
$ mysql -uroot

以下は mysql コンソールで実行
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
```

* 設定ファイル
```aidl
~/.my.cnf に書く
[client]
default-character-set = utf8mb4

[mysql]
default-character-set = utf8mb4

[mysqld]
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
init-connect='SET NAMES utf8mb4;SET AUTOCOMMIT=0'
skip-character-set-client-handshake
lower_case_table_names=1
sql_mode=NO_ENGINE_SUBSTITUTION
#log-slow-queries=/tmp/slow.log
#long-query-time=30
#log-queries-not-using-indexes
#log-slow-admin-statements
#log=/tmp/query.log
max_allowed_packet=32MB

```
## 起動までの手順  
* gitのリモートリポジトリをクローン
````
git clone git@bitbucket.org:teamlabengineering/okuyama_itemapi.git
````
* クローンしたディレクトリに移動
````
cd okuyama_itemapi
````

* mysqlサーバーの起動
````
mysql.server start
````
* アプリの起動  
````
sbt ~run
````

* インフラ構成図  
https://drive.google.com/file/d/14WvHx45BYPMB-EIg4UqyyLek7xW_LbFU/view?usp=sharing




