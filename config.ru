# config.ru
require './main'
require 'rack/protection'
disable :protection
run Sinatra::Application
