require 'bundler'
Bundler.require :default

module Launching
  class Application < Sinatra::Base
    configure do
      require 'net/http'

      CACHE = Dalli::Client.new
    end

    get '/pages/launcher/na' do
      content_type :js
      unless content = CACHE.get('/pages/launcher/na')
        uri = URI.parse 'http://ll.leagueoflegends.com/pages/launcher/na'
        request = Net::HTTP::Get.new uri.path
        response = Net::HTTP.start uri.host, uri.port do |http|
          http.request request
        end
        response.body =~ /refreshContent\((.*)\);/
        data = JSON.parse $1
        data['status'] = true
        data['serverStatus'] = 1
        data['news'].unshift({ 'title' => 'Brought to you by Benjamin Manns', 'url' => 'http://benmanns.com', 'date' => Time.new.strftime('%m.%d.%Y') })
        data['community'].unshift({ 'title' => 'Brought to you by Benjamin Manns', 'url' => 'http://benmanns.com' })
        content = "\r\nrefreshContent(#{data.to_json});"
        CACHE.set '/pages/launcher/na', content, 300
      end
      content
    end

    get '/services/connection_info' do
      content_type :json
      { :ip_address => request.ip }.to_json
    end

    get '/HNAP1/' do
      halt 404
    end

    get '/TEADevInfo/' do
      halt 404
    end

    post '/harassment_report/add/na' do
      uri = URI.parse 'http://ll.leagueoflegends.com/harassment_report/add/na'
      request = Net::HTTP::Post.new uri.path
      request.set_form_data params
      response = Net::HTTP.start uri.host, uri.port do |http|
        http.request request
      end
      response.body
    end
  end
end
