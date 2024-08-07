# README

# Cocomic

cocomicでは近くの漫画本などをおいてあるお店を調べることができます。また、「予約チケット」を発行することでその本を借りることもできます。

# URL
http://18.180.247.184/ ※閉鎖中


# テスト用アカウント
## ショップ
Email:    test@com<br>
password: test0000
## ユーザー
Email:    test@com<br>
password: test0000

# 利用方法
## ショップ側
トップページメニューの「ショップ登録はこちら」からログインすることができます。
ショップ側でできることは主に「ショップ名、住所、店内の写真、お店の説明の登録」、「おいてある漫画本の登録」、「予約チケットの確認」です。
### 「ショップ名、住所、店内の写真、お店の説明の登録」
ログイン後、ヘッダーに「基本情報」というボタンがあります。そこをクリック後ショップ情報の編集ページへ遷移し、店内の写真や、お店の説明を登録することができます。
### 「おいてある漫画本の登録」
ログイン後、ヘッダーに「コミック登録」というボタンがあります。そこをクリックするとコミック登録ページへ遷移します。検索欄に本のタイトルを入力し検索すると本の一覧が表示されるので、一覧の中の「登録する」というボタンを押すとその本を登録することができます。
### 「予約チケットの確認」
ログイン後、お店の詳細ページに遷移しています。お店の説明の下の方に登録した本のタイトルが一覧で表示されています。予約チケットが発行されていればタイトルの横に「チケットを確認する」というボタンが表示されます。そのボタンをクリックするとチケットの詳細を確認することができます。

## ユーザー側
トップページの「ログイン」ボタンからログインすることができます。
ユーザー側でできることは「ショップの検索」、「予約チケットの発行、確認、削除」です。
### 「ショップの検索」
ユーザーのトップページの検索欄に都道府県を選択し、本のタイトルを入力し、検索します。選択した都道府県内の入力した本が登録されているお店が一覧で表示され、そのお店をクリックすることでお店の詳細ページに行くことができます。
### 「予約チケットの発行、確認、削除」
お店の詳細ページでは登録されている本のタイトルが一覧で表示されています。予約可能であればタイトルの横に「予約する」の文字があり、そこをクリックすることでチケットの発行ページに遷移します。チケット発行ページで「本を取りに行く日」「借りておく期間」を入力することでチケットを作成できます。トップページでは発行したチケットが一覧で表示されています。チケットの「表示する」ボタンをクリックすることでそのチケットの詳細ページへ遷移することができます。チケットの詳細ページではチケットを削除することができます。

# 目指した課題解決
このアプリケーションではカフェやラーメン屋などで漫画を読みたい人と漫画本を設置しているお店を紐づけることを課題にしています。また、漫画を読みにくることでそのお店の来店者数も増加することも狙いです。そのためにはそのお店の設置してある漫画本をいかにわかりやすくユーザーに知ってもらうか、そして来店者数を増やすために利用目的を増やす方法と言う点が課題となりました。

# 要件定義
それらの課題を実現するためにショップ側とユーザー側にそれぞれ以下のような機能を実装しました。
## ショップ側
### コミック登録機能
ユーザーが調べたお店にどのような本があるかを知ることができるようにショップ側で本を登録する機能。
楽天ブックスAPIを使っていることで、タイトルで本を検索することができます。そして本についているisbnという番号を登録することでその登録される本に一意性を持たせています。
![comic登録](https://user-images.githubusercontent.com/78079392/111961425-6391ec80-8b34-11eb-88b2-8ca30dec43ee.gif)
![comic登録２](https://user-images.githubusercontent.com/78079392/111963312-b4a2e000-8b36-11eb-865f-0301d469f90a.gif)
### 地図表示機能
ユーザーがお店の詳細ページを訪れた際、住所がわかりやすいように地図を表示しています。
GoogleMapAPIを使い、あらかじめ登録されていたショップの住所をもとに、その周辺の地図を表示しています。
![openmap](https://user-images.githubusercontent.com/78079392/111963359-c3899280-8b36-11eb-8767-14c6d44462cf.gif)


## ユーザー側
### 本の検索機能
まず読みたい本をショップ側同様楽天ブックスAPIを使い、検索します。そこで得た情報をもっているショップを一覧で検索結果ページに表示します。
また、地域を選択することで地域を限定することができます。
![u-comic](https://user-images.githubusercontent.com/78079392/111963409-d43a0880-8b36-11eb-8e90-32c8ec59b038.gif)
![u-comic2](https://user-images.githubusercontent.com/78079392/111963439-def49d80-8b36-11eb-82ca-007e51d06003.gif)
### レンタルチケット機能
ショップへの利用目的を増やすため、レンタルチケット機能を実装しました。
ショップの詳細ページに登録されている本からレンタルチケットを発行することでその本を借りることができると言う機能です。
チケットは「お店に取りに行く日」「借りておく期間」を入力することで発行することができます。
![ticket1](https://user-images.githubusercontent.com/78079392/111963488-ef0c7d00-8b36-11eb-89cf-e16c7c625b17.gif)
![ticket2](https://user-images.githubusercontent.com/78079392/111963552-ffbcf300-8b36-11eb-8116-abb4e021e886.gif)



# 実装予定の機能
## ショップ側
### チケット発行機能
「ショップ側があらかじめ発行したものをユーザーが買う」とすることでショップ側がチケットを管理しやすくなります。
ユーザー側では決められたチケットを買う、ということでその時間にその本がお店にあるのか確実に知ることができます。
### サービス紹介機能
ショップ側の行っているサービスを紹介する欄を儲けることで、ユーザー側にもそのお店の情報がよりわかりやすくなります。

## ユーザー側
### お気に入り機能
ショップに対し、お気に入り機能をつけることでそのお店に対しリピートしやすくなります。
お気に入りしたショップに対しては本を検索せずにショップの詳細ページに移動することができます。

# テーブル設計

## users テーブル
| Column             | Type   | Option                    |
| ------------------ | ------ | ------------------------- |
| name               | string	| null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string	| null: false               |

### Association
- has_many :tickets 

## shops テーブル

| Column             | Type    | Option                    |
| ------------------ | ------- | ------------------------- |
| name               | string	 | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string	 | null: false               |
| area_id            | integer | null: false               |
| city               | string	 | null: false               |
| add_line           | string  | null: false               |
| build              | string	 | null: false               |
| text               | date    | null: false               |

### Association
- has_many :shop_items

## shop_items テーブル
| Column       | Type       | Option                          |
| ------------ | ---------- | ------------------------------- |
| isbn         | integer    | null: false                     |
| shop         | references | null: false , foreign_key: true |

### Association
- belongs_to :shop
- has_one    :ticket

## tickets テーブル
| Column             | Type       | Option                          |
| ------------------ | ---------- | ------------------------------- |
| get_day            | date       | null: false                     |
| having_day         | integer    | null: false                     |
| isbn               | integer    | null: false                     |
| shop_item          | references | null: false , foreign_key: true |
| user               | references | null: false , foreign_key: true |

### Association
- belongs_to :shop_item
- belongs_to :user

# ローカル環境
### バージョン
ruby 2.6.5<br>
Rails 6.0.3.5<br>
Homebrew 3.0.1<br>
node 14.15.4<br>
yarn 1.22.10<br>
### git clone

```ターミナル.
% git clone https://github.com/taka-elle/cocomic.git
% cd cocomic
% bundle install
% yarn install
```
