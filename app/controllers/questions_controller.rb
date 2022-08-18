class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update show destroy edit hide]

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to root_path, notice: "Новый вопрос создан!"
    else
      flash.now[:alert] = "Некорректный вопрос!"

      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to root_path, notice: "Вопрос сохранен!"
    else
      flash.now[:alert] = "Некорректный вопрос!"

      render :edit
    end

  end

  def destroy
    @question.destroy

    redirect_to root_path, notice: "Вопрос удален!"
  end

  def show
  end

  def index
    @questions = Question.all
    @question = Question.new
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
  end

  def edit
  end

  def hide
    @question.update(hidden: true)

    redirect_to root_path, notice: "Вопрос скрыт!"
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
