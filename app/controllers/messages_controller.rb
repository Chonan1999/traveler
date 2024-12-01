class MessagesController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
        Rails.logger.debug "Params: #{params[:message]}" # パラメータをログに出力
        @message = current_user.messages.new(message_params)
        if @message.save
         Rails.logger.debug "Params: #{params[:message]}" # パラメータをログに出力
         redirect_to room_path(@message.room_id), notice: "メッセージを送信しました！"
        else
          Rails.logger.debug "Message save failed: #{@message.errors.full_messages}" # エラー内容をログに出力
          flash[:alert] = "メッセージ送信に失敗しました。"
          redirect_to room_path(params[:message][:room_id])
        end
    end

    private

    def message_params
      params.require(:message).permit(:content, :room_id)
    end
end
