class TropoController < ApplicationController
  def index
    response = Tropo::Generator.say 'Hello World!'
    puts "Tropo Response : #{response}"
    render :text => response, :content_type => 'application/json'
  end

  def hello 
    response = Tropo::Generator.say 'Hello World!'
    puts "Tropo Response : #{response}"
    render :text => response, :content_type => 'application/json'
  end

end
