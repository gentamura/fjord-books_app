# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_parent, only: %i[create update destroy]
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = @parent.comments.new(comment_params)

    if @comment.save
      redirect_to @parent, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @parent, alert: @comment.errors.full_messages.join(" ")
    end
  end

  def update
    if @comment.update(comment_params)
      render json: { comment: @comment, status: :ok, status_code: 200 }
    else
      render json: { errors: @comment.errors, status: :unprocessable_entity, status_code: 422 }
    end
  end

  def destroy
    @comment.destroy

    redirect_to url_for(@parent), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_parent
    if params[:report_id]
      @parent = Report.find(params[:report_id])
    elsif params[:book_id]
      @parent = Book.find(params[:book_id])
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end
