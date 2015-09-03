#!rubyw
#coding: utf-8

require "bundler"
Bundler.require

URL = "http://stocks.finance.yahoo.co.jp/stocks/detail/"

#
# StockTrayApp
#
class StockTrayApp

  # コンストラクタ
  def initialize(argv)
    @app = Qt::Application.new(argv)

    # 値下がりアイコン
    @dw_icon = Qt::Icon.new(File.dirname(__FILE__) + '/icons/chart_down_color.png')
    # 値上がりアイコン
    @up_icon = Qt::Icon.new(File.dirname(__FILE__) + '/icons/chart_up_color.png')
    # 読み込み中アイコン
    @rf_icon = Qt::Icon.new(File.dirname(__FILE__) + '/icons/arrow_refresh.png')

    # メニュー用フォント
    # 固定幅フォントでないとずれるので
    @menu_font = Qt::Font.new("MS Gothic")
  end

  # メイン処理
  def main
    # トレイアイコン作成
    @si = Qt::SystemTrayIcon.new
    @si.icon = @rf_icon
    @si.connect(SIGNAL('activated(QSystemTrayIcon::ActivationReason)')) do |reason|
      case reason
        when Qt::SystemTrayIcon::Trigger
          on_timer_timeout
      end
    end
    @si.show

    # タイマ処理作成
    Qt::Timer.new(@app) do |timer|
      timer.connect(SIGNAL('timeout()')) do
        on_timer_timeout
      end
      timer.start(60 * 1000)
    end
    on_timer_timeout

    # イベントループ開始
    @app.exec
  end

  # コードから情報を取得しQTActionを作る
  def create_action(code)
    doc = Nokogiri::HTML(open("#{URL}?code=#{code}").read)
    nam = doc.css('.symbol > h1').last.text
    chg = doc.css('.yjMSt').last.text

    nam_mod = nam.gsub("(株)", "").tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
    chg_part1, chg_part2 = chg.split("（")
    

    action = Qt::Action.new(sprintf("%-8d[%s] %7s （%s", code, nam_mod[0..2], chg_part1, chg_part2), @si)
    action.font = @menu_font
    if chg.start_with?("+")
      action.icon = @up_icon
    else
      action.icon = @dw_icon
    end

    return action
  end

  # タイマのイベントハンドラ
  def on_timer_timeout
    # トレイを読み込み中アイコンにする
    @si.icon = @rf_icon
    begin
      # 設定ファイルから銘柄一覧を読み込む
      txt = File.read("#{File.dirname(__FILE__)}/config.yaml")
      config = YAML.load(txt)
      codes = config["codes"]

      menu = Qt::Menu.new

      # 銘柄情報をメニューに追加
      codes.each do |code|
        action = create_action(code)
        menu.addAction(action)
      end
      menu.addSeparator()

      # 日経平均をメニューに追加
      # 日経平均の値上がり／値下がりに応じてトレイアイコンを変える
      begin
        action = create_action(998407)
        @si.icon = action.icon
        menu.addAction(action)
      end
      menu.addSeparator()

      # 終了メニューを追加
      begin
        action = Qt::Action.new('QUIT', @si)
        action.font = @menu_font
        action.connect(SIGNAL(:triggered)) do
          @si.hide
          @app.quit
        end
        menu.addAction(action)
      end

      # コンテキストメニュー再セット
      @si.contextMenu = menu
    end
  end
end

StockTrayApp.new(ARGV).main()
