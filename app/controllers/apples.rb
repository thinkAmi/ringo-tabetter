RingoTabeta.controllers :apples do
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
    render "apples/index"
  end

  get :api, provides: :json, map: "/api" do

    tweets = Apple.count_apple
    # logger.info(tweets.to_json)

    add_color(tweets).to_json
  end

  get :delete, map: "/delete" do
    unless ENV["PADRINO_ENV"] == :productoin
      Apple.delete_all
      Tweet.delete_all
    end
  end

end
