class EventsController < ApplicationController
  before_action :set_event, only: %i[show]
  def new 
    @event = current_user.created_events.build
  end

  def create 
    @event = current_user.created_events.build(event_params)
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

  def set_event 
    @event = Event.find(params[:id])
  end

end
