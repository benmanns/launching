module Launching
  class Application < Sinatra::Base
    configure do
      require 'open-uri'
    end

    get '/pages/launcher/na' do
      content_type :js
      halt 500 unless open('http://ll.leagueoflegends.com/pages/launcher/na').read =~ /refreshContent\((.*)\);/
      data = JSON.parse $1
      data['status'] = true
      data['serverStatus'] = 1
      data['news'].unshift({ 'title' => 'Brought to you by Benjamin Manns', 'url' => 'http://benmanns.com', 'date' => Time.new.strftime('%m.%d.%Y') })
      data['community'].unshift({ 'title' => 'Brought to you by Benjamin Manns', 'url' => 'http://benmanns.com' })
      "\r\nrefreshContent(#{data.to_json});"
    end

    get '/services/connection_info' do
      content_type :json
      { :ip_address => request.ip }.to_json
    end
  end
end
