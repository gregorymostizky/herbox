require 'open-uri'
require 'cgi'

class TropoController < ApplicationController
  def index
  end

  def hello 
    to = params[:session][:params][:name]
    msg = params[:session][:params][:msg]

#    response = Tropo::Generator.say 'Hello World! Would you like a piece of cake?'
#    puts "Tropo Response : #{response}"

    tropo = Tropo::Generator.new do
      call(:to => to, :network => 'Jabber')
      say(:value => msg)
    end
    
    render :text => tropo.response, :content_type => 'application/json'
  end

  def start
    session_uri =  "https://api.tropo.com/1.0/sessions?action=create&token=#{TROPO_TOKEN_MESSAGING}"
    session_uri += "&name=#{CGI.escape(params[:start][:name])}"
    session_uri += "&msg=#{CGI.escape(params[:start][:msg])}"
    response = open session_uri
    render :text => "Conversation Started: #{response}"
  end
end
