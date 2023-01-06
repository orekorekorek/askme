class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.with_questions.find_by!(name: params[:name])
    @questions = @hashtag.questions.includes(%i[user author question_hashtags hashtags]).desc
  end
end
