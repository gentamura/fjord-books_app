# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_polymorphic, only: %i[create update destroy]
  before_action :set_comment, only: %i[update destroy]

  def create
    @comment = Comment.new(comment_params.merge(@polymorphic_hash))

    if @comment.save
      redirect_to @polymorphic_obj, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to report_path(@polymorphic_obj.id)
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

    redirect_to @polymorphic_url, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_polymorphic
    if params[:report_id]
      report = Report.find(params[:report_id])

      @polymorphic_obj = report
      @polymorphic_hash = { reportable: report, userable: current_user }
      @polymorphic_url = url_for(controller: :reports, action: :show, id: report.id, only_path: true)
    elsif params[:book_id]
      book = Book.find(params[:book_id])

      @polymorphic_obj = book
      @polymorphic_hash = { bookable: book, userable: current_user }
      @polymorphic_url = url_for(controller: :books, action: :show, id: book.id, only_path: true)
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
