#!ruby
#coding: utf-8

require "bundler"
Bundler.require

# 基準ディレクトリ
BASE_DIR  = File.expand_path(File.dirname(__FILE__) + '/..')
# RubyのEXE
RUBY_EXE  = RbConfig::CONFIG['bindir'].to_s + '/rubyw.exe'
# ショートカットファイル
SC_FILE   = BASE_DIR + '/StockTray.lnk'
# 設定ファイル
CFG_FILE  = BASE_DIR + '/config.yaml'

# ショートカット作成
Win32::Shortcut.new(SC_FILE) do |s|
  s.path              = RUBY_EXE
  s.arguments         = "main.rb"
  s.working_directory = BASE_DIR
  s.show_cmd          = Win32::Shortcut::SHOWMINNOACTIVE
end

# 設定ファイル作成
unless File.exist?(CFG_FILE)
  FileUtils.cp(CFG_FILE + '.sample', CFG_FILE)
end
