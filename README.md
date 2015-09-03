# StockTray

タスクトレイ常駐型の株価ビューア。

こっそり株価チェックするのにべんり。

# スクリーンショット

![イメージ1](https://github.com/kinumi/StockTray/raw/master/doc/1.png)

↑タスクトレイに常駐する。日経平均上昇時は緑矢印、下降時は赤矢印。

![イメージ2](https://github.com/kinumi/StockTray/raw/master/doc/2.png)

↑右クリックすると登録銘柄の一覧が表示される。

# 動作環境

- ruby 2.0.0 [i386-mingw32] http://rubyinstaller.org/
- bundler
- 使用メモリはタスクマネージャ読みで50MBほど

# 初期設定

好きなところにこのリポジトリのコピーを配置し、`setup.bat`を実行してください。

bundlerによる依存ライブラリのインストール、および起動用ショートカット（StockTray.lnk）の作成を行います。
ショートカットはスタートメニューやスタートアップなど、好きなところに配置してください。


コマンドで実施する例：
```
> git clone https://github.com/kinumi/StockTray.git
> cd StockTray
> setup.bat
```

# 銘柄登録

銘柄は設定ファイル`config.yml`に登録します。

```yaml:config.yaml
---
codes:
  - 8411
  - 5491
  - 9501
```
一行に銘柄コードを1行ずつ書きます。

# 株価データ

株価データはYahoo! ファイナンスから取得し表示します。

# 使用アイコン

Free FatCow-Farm Fresh Icons (CC BY 3.0ライセンス)

http://www.fatcow.com/free-icons

# ライセンス

NYSLとします。

http://www.kmonos.net/nysl/
