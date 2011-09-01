class TropoController < ApplicationController
  def index
    render :text => 'hello'
  end

  def hello 
    response = Tropo::Generator.say 'Hello World! Would you like a piece of cake?'
    puts "Tropo Response : #{response}"
    render :text => response, :content_type => 'application/json'
  end

end
