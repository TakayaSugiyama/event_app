class EventsController < ApplicationController
  def new 
    @event = current_user.events.build
  end

  def create 
    @event = current_user.events.build(event_params)
    if @event.save 
      redirect_to @event, notice: "作成しました"
    else 
      render :new
    end
  end

  private 

  def event_params 
    params.require(:event).permit(:name,:place,:start_time,:end_time, :content)
  end

end
