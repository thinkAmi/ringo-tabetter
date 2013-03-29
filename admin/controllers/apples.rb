RingoTabeta::Admin.controllers :apples do
  get :index do
    @title = "Apples"
    @apples = Apple.all
    render 'apples/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'apple')
    @apple = Apple.new
    render 'apples/new'
  end

  post :create do
    @apple = Apple.new(params[:apple])
    if @apple.save
      @title = pat(:create_title, :model => "apple #{@apple.id}")
      flash[:success] = pat(:create_success, :model => 'Apple')
      params[:save_and_continue] ? redirect(url(:apples, :index)) : redirect(url(:apples, :edit, :id => @apple.id))
    else
      @title = pat(:create_title, :model => 'apple')
      flash.now[:error] = pat(:create_error, :model => 'apple')
      render 'apples/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "apple #{params[:id]}")
    @apple = Apple.find(params[:id])
    if @apple
      render 'apples/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'apple', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "apple #{params[:id]}")
    @apple = Apple.find(params[:id])
    if @apple
      if @apple.update_attributes(params[:apple])
        flash[:success] = pat(:update_success, :model => 'Apple', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:apples, :index)) :
          redirect(url(:apples, :edit, :id => @apple.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'apple')
        render 'apples/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'apple', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Apples"
    apple = Apple.find(params[:id])
    if apple
      if apple.destroy
        flash[:success] = pat(:delete_success, :model => 'Apple', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'apple')
      end
      redirect url(:apples, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'apple', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Apples"
    unless params[:apple_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'apple')
      redirect(url(:apples, :index))
    end
    ids = params[:apple_ids].split(',').map(&:strip).map(&:to_i)
    apples = Apple.find(ids)
    
    if Apple.destroy apples
    
      flash[:success] = pat(:destroy_many_success, :model => 'Apples', :ids => "#{ids.to_sentence}")
    end
    redirect url(:apples, :index)
  end
end
