Admin.controllers :apples do

  get :index do
    @apples = Apple.all
    render 'apples/index'
  end

  get :new do
    @apple = Apple.new
    render 'apples/new'
  end

  post :create do
    @apple = Apple.new(params[:apple])
    if @apple.save
      flash[:notice] = 'Apple was successfully created.'
      redirect url(:apples, :edit, :id => @apple.id)
    else
      render 'apples/new'
    end
  end

  get :edit, :with => :id do
    @apple = Apple.find(params[:id])
    render 'apples/edit'
  end

  put :update, :with => :id do
    @apple = Apple.find(params[:id])
    if @apple.update_attributes(params[:apple])
      flash[:notice] = 'Apple was successfully updated.'
      redirect url(:apples, :edit, :id => @apple.id)
    else
      render 'apples/edit'
    end
  end

  delete :destroy, :with => :id do
    apple = Apple.find(params[:id])
    if apple.destroy
      flash[:notice] = 'Apple was successfully destroyed.'
    else
      flash[:error] = 'Unable to destroy Apple!'
    end
    redirect url(:apples, :index)
  end
end
