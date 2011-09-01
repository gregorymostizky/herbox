require 'open-uri'

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
    open("https://api.tropo.com/1.0/sessions?action=create&token=#{TROPO_TOKEN_MESSAGING}&name=#{params[:start][:name]}&msg=#{params[:start][:msg]}")
    render :text => 'Conversation Started'
  end
end
