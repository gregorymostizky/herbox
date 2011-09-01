require 'open-uri'

class TropoController < ApplicationController
  def index
  end

  def hello 
#    response = Tropo::Generator.say 'Hello World! Would you like a piece of cake?'
#    puts "Tropo Response : #{response}"

    tropo = Tropo::Generator.new do
      call(:to => 'gregory.mostizky@gmail.com', :network => 'Jabber')
      say(:value => 'Game Over Man')
    end
    
    render :text => tropo.response, :content_type => 'application/json'
  end

  def start 
    open("https://api.tropo.com/1.0/sessions?action=create&token=#{TROPO_TOKEN_MESSAGING}&name=#{params[:name]}&msg=#{params[:msg]}")
  end
end
