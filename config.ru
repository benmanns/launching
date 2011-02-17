$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')

require 'bundler'
Bundler.require :default

require 'launching'

use Launching::Application
run Sinatra::Application
