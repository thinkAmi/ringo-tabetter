# -*- coding: utf-8 -*-
RingoTabeta::App.controllers :apples do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :index, map: "/" do
    @highchart_path = "/javascripts/total.js"
    @home_active = "active"
    render "apples/index"
  end


  get :month, map: "/month" do
    @highchart_path = "/javascripts/month.js"
    @month_active = "active"
    render "apples/month"
  end


  get :api, provides: :json, map: "/api/total" do
    tweets = Apple.count_apple

    add_color(tweets).to_json
  end


  get :api_month, provides: :json, map: "/api/month" do
    tweets = Apple.count_apple_monthly

    collect_by_name(tweets).to_json
  end


  get :delete, map: "/delete" do
    return "Can not Delete" unless ENV["PADRINO_ENV"] == "development"

    Apple.delete_all
    Tweet.delete_all

    logger.info("Delete All")
    "Delete All !!"
  end

end
