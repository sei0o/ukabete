require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_record'
require 'yaml'
require 'erb'
require 'base64'
require_relative './models/post'

db_config = YAML.load ERB.new(File.read("database.yml")).result
ActiveRecord::Base.establish_connection db_config["development"]

class Ukabete < Sinatra::Base
  configure do
    register Sinatra::Reloader
  end

  helpers do

  end

  get "/" do
    slim :index
  end

  post "/" do
    post = Post.new
    post.message = params[:message]
    post.threshold = params[:threshold]
    if params[:file]
      tmp = params[:file][:tempfile] # ファイルに保存
      extension = params[:file][:filename].split(".").last # 拡張子
      File.open "./public/images/#{Post.count + 1}.#{extension}", "wb" do |f|
        f.write tmp.read
      end

      post.url = "/images/#{Post.count + 1}.#{extension}" # そのurlを保存
    else
      post.url = params[:url]
    end

    if post.save
      redirect "/#{post.id}"
    else
      halt "保存できませんねぇ..."
    end
  end

  get "/*/?" do |id|
    @post = Post.find id
    slim :image
  end
end
