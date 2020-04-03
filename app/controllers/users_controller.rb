class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def retire
  end

  def destroy
    @user = User.find(params[:id])
    events = @user.created_events
    if @user.destroy
      events.each { |event| event.update_columns(owner_id: nil) }
      redirect_to root_path, notice: "退会が完了しました"
    else
      flash.now[:notice] = "確認事項を確認してください"
      render :retire
    end
  end
end
