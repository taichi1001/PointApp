# pointapp

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## DBテーブル

- レコード情報

| 名前            | データ型   |  属性       | NULL | デフォルト値 | コメント | その他 |
|-----------------|-----------|-------------|------|-------------|---------|--------|
| recordId        | INTEGER   | PRIMARY KEY | no   | なし         | ID      | AUTO_INCREMENT |
| date            | TEXT      |             | no   | なし         | 日付 　　|  　　|
| title           | TEXT      |             | no   | なし         | タイトル |  　　|
| number_people   | INTEGER   |             | no   | なし         | 人数 　　|  　　|
| mode            | TEXT      |             | no   | なし         | モード 　|  　　|
| is_edit         | INTEGER   |             | no   | なし         | 編集モードかどうか | 必要ないかも|

- コンテンツ情報

| 名前               | データ型   |  属性       | NULL | デフォルト値 | コメント | その他 |
|--------------------|-----------|-------------|------|-------------|---------|--------|
| record_contents_Id | INTEGER   | PRIMARY KEY | no   | なし         | ID      | AUTO_INCREMENT |
| record_id          | INTEGER   |             | no   | なし         | レコード情報のID |  　　|
| name_id            | INTEGER   |             | no   | なし         | 名前情報のID |  　　|
| count              | INTEGER   |             | no   | なし         | 何試合目の情報か 　　|  　　|
| score              | INTEGER   |             | no   | なし         | スコア 　| レコードのモードによって役割変わる　|

- 名前情報

| 名前    | データ型   |  属性       | NULL | デフォルト値 | コメント | その他 |
|---------|-----------|-------------|------|------------|---------|--------|
| name_Id | INTEGER   | PRIMARY KEY | no   | なし        | ID      | AUTO_INCREMENT |
| name    | TEXT      | UNIQUE      | no   | なし        | 名前    |  　　|

- レコードと名前の紐づけ情報

| 名前               | データ型   |  属性                        | NULL | デフォルト値 | コメント | その他 |
|--------------------|-----------|-----------------------------|------|-------------|---------|--------|
| correspondence_id　| INTEGER   | PRIMARY KEY                  | no   | なし         | ID      | AUTO_INCREMENT |
| record_id          | INTEGER   | UNIQUE(name_idと組み合わせ)   | no   | なし         | レコード情報のID |  　　|
| name_id            | INTEGER   | UNIQUE(record_idと組み合わせ) | no   | なし         | 名前情報のID |  　　|

- 順位とレートの紐づけ情報

| 名前            | データ型   |  属性       | NULL | デフォルト値 | コメント | その他 |
|---------------- |-----------|------------ |------|-------------|---------|--------|
| rank_rate_id    | INTEGER   | PRIMARY KEY | no   | なし         | ID      | AUTO_INCREMENT |
| record_id       | INTEGER   |             | no   | なし         | レコード情報のID |  　　|
| rank            | INTEGER   |             | no   | なし         | 順位 　　|  　　|
| rate            | INTEGER   |             | no   | なし         | レート　 |  　　|

## 追加予定機能

- レコードのタグ付け
- タグごとの成績ランキング
- 個人成績グラフ
