class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show]

  def index
    @users = User.page(params[:page]).per(5).reverse_order
  end
   
  def show
    @user = User.find(params[:id])
    @current_entry=Entry.where(user_id: current_user.id)
    @another_entry=Entry.where(user_id: @user.id)

    @isRoom = false
    unless @user.id == current_user.id
      @current_entry.each do |cu|
        @another_entry.each do |u|
          Rails.logger.debug "DEBUG: Comparing cu.room_id = #{cu.room_id} with u.room_id = #{u.room_id}" # 比較のログ
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
            break
          end
        end
        break if @isRoom
      end

      unless @isRoom
        @room = Room.create # Roomを新規作成
        Entry.create(user_id: current_user.id, room_id: @room.id) # 現在のユーザー用Entry作成
        Entry.create(user_id: @user.id, room_id: @room.id) # 相手ユーザー用Entry作成
      end
    end
    Rails.logger.debug "DEBUG: @isRoom = #{@isRoom}" # 追加
    Rails.logger.debug "DEBUG: @roomId = #{@roomId}" # 追加
    
    @posts = @user.posts.page(params[:page]).per(8).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)
  end
end