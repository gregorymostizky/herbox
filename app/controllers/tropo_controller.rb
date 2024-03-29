require 'open-uri'
require 'cgi'

class TropoController < ApplicationController
  def index
  end

  def hello 
    #to = params[:session][:parameters][:name] rescue nil
    #msg = params[:session][:parameters][:msg] rescue nil

    from = params[:session][:from][:id] rescue nil
    txt = params[:session][:initialText] rescue nil

    tropo = Tropo::Generator.new do
      #call(:to => to || from, :from => 'herbox@tropo.im', :network => 'Jabber')
      ask(
        :name => 'question',
        :timeout => 120,
        :say => {:value => "Have you ever tried safito?"},
        :choices => {:value => "yes, no"}
      )
      on :event => 'continue', :next => '/tropo/answer'
      on :event => 'incomplete', :next => '/tropo/noanswer'
    end

    puts "TROPO: #{tropo.response}"
    render :text => tropo.response, :content_type => 'application/json'
  end

  def answer
    answer = params[:result][:actions][:value]
    tropo = Tropo::Generator.new do
      say :value => "Your answer is #{answer}"
    end

    render :text => tropo.response, :content_type => 'application/json'
  end

  def noanswer
    tropo = Tropo::Generator.new do
      say :value => 'Are you trippin mon?'
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
