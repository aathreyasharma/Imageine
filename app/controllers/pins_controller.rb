class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  respond_to :html
  
  def index
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
  end

  def show
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.' 
    else
      render action: 'new'
    end
  end
   
 

def update
    if @pin.update(pin_params)
        redirect_to @pin, notice: 'Pin was successfully updated.'
    else
        render action: 'edit'
    end
end 
        
    

def destroy
    @pin.destroy
    redirect_to pins_url
end

def upvote
  @pin.upvote_by current_user
  redirect_to :back
end
  

  private
    def find_pin
      @pin = Pin.find(params[:id])
    end

    def pin_params
      params.require(:pin).permit(:description, :image, :name, :title)
    end


def correct_user
  @pin = current_user.pins.find_by(id: params[:id])
  redirect_to pins_path, notice: "Not authorized to edit this Pin" if @pin.nil?
end

end
