class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(name: params[:name])

    if @hashtag.questions.present?
      @questions = @hashtag.questions
    else
      flash.now[:alert] = 'Такого хэштега не существует!'

      redirect_to_root_with_alert
    end
  end
end
