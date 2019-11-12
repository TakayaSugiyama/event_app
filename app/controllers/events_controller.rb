class EventsController < ApplicationController
  before_action :set_event, only: %i[show  update]
  PER = 10

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

  def show 
    @tickets = @event.tickets.includes(:user).order(:created_at)
    @ticket = current_user && current_user.tickets.find_by(event_id: params[:id])
  end

  def index 
    @events = Event.page(params[:page]).where('start_time > ?', Time.zone.now).order(:start_time)
    @q = Event.page(params[:page]).where('start_time > ?', Time.zone.now).ransack(params[:q])
    if params[:q]
      @events = @q.result(distinct: true)
    end
  end

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  def update 
    @event = current_user.created_events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: "更新しました"
    else 
      render :edit
    end
  end


  def destroy 
    @event = current_user.created_events.find(params[:id])
    @event.destroy
    redirect_to root_path, notice: "削除しました"
  end

  private 

  def event_params 
    params.require(:event).permit(:name,:place,:start_time,:end_time, :content)
  end

  def set_event 
    @event = Event.find(params[:id])
  end

end
