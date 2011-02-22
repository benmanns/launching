$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'launching'

use Launching::Application
run Sinatra::Application
