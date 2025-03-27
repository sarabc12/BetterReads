class QuestionsController < ApplicationController

  def index
    @questions = policy_scope(Question)
    @questions = current_user.questions
    @question = Question.new
  end

  def create
    @questions = current_user.questions
    @question = Question.new(question_params)
    @question.user = current_user
    authorize @question
    if @question.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append(:questions, partial: "questions/question", locals: { question: @question }),
            turbo_stream.replace('question-form', partial: 'form', locals: { question: Question.new })
          ]
        end
        format.html { redirect_to questions_path }
      end
    else
     render :index, status: :unprocessable_entity
    end
  end


  private

  def question_params
    params.require(:question).permit(:user_question, :ai_answer)
  end
end
