Admin.controllers :tweets do

  get :index do
    @tweets = Tweet.all
    render 'tweets/index'
  end

  get :new do
    @tweet = Tweet.new
    render 'tweets/new'
  end

  post :create do
    @tweet = Tweet.new(params[:tweet])
    if @tweet.save
      flash[:notice] = 'Tweet was successfully created.'
      redirect url(:tweets, :edit, :id => @tweet.id)
    else
      render 'tweets/new'
    end
  end

  get :edit, :with => :id do
    @tweet = Tweet.find(params[:id])
    render 'tweets/edit'
  end

  put :update, :with => :id do
    @tweet = Tweet.find(params[:id])
    if @tweet.update_attributes(params[:tweet])
      flash[:notice] = 'Tweet was successfully updated.'
      redirect url(:tweets, :edit, :id => @tweet.id)
    else
      render 'tweets/edit'
    end
  end

  delete :destroy, :with => :id do
    tweet = Tweet.find(params[:id])
    if tweet.destroy
      flash[:notice] = 'Tweet was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Tweet!'
    end
    redirect url(:tweets, :index)
  end
end
