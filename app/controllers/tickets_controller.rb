class TicketsController < ApplicationController
  def create
    ticket = current_user.tickets.build do |t|
      t.event_id = params[:event_id]
      t.comment = params[:ticket][:comment]
    end 

    if ticket.save 
      flash[:notice] = "イベント参加を表明しました"
      head 201
    else
      
    end
  end
end
