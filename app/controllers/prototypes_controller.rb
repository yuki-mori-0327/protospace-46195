class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  
  def index
    @prototypes = Prototype.includes(:user).all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
    
  def show
   @prototype = Prototype.find(params[:id]) 
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
   @prototype = Prototype.find(params[:id])
  end

  def update
   @prototype = Prototype.find(params[:id])
  if @prototype.update(prototype_params)
    redirect_to prototype_path(@prototype), notice: "プロトタイプを更新しました"
  else
    render :edit, status: :unprocessable_entity
  end
 end

 def destroy
  @prototype = Prototype.find(params[:id])
   if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

 private

 def set_prototype
  @prototype = Prototype.find(params[:id])
end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
