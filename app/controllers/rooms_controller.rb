class RoomsController < ApplicationController

  before_action :authenticate_user!

    def create
      @room = Room.create(user_id: current_user.id)
      @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
      @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
      redirect_to "/rooms/#{@room.id}"
    end
    
    def show
      @room = Room.find(params[:id])
      @entries = @room.entries.includes(:user)
      if @entries.size == 2
        @user1 = @entries.first.user
        @user2 = @entries.second.user
      else
        # 万が一、エントリーが2人未満の場合の処理
        redirect_to root_path, alert: "このルームには十分な参加者がいません。"
      end
      @messages = @room.messages.includes(:user)
      @message = Message.new
    end
  end