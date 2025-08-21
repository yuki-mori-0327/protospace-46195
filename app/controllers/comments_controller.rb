class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to prototype_path(@prototype), notice: "コメントを投稿しました" }
        format.turbo_stream
      else
        format.html do
          @comments = @prototype.comments
          render "prototypes/show", status: :unprocessable_entity
        end
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "comment_form",
            partial: "comments/form",
            locals: { prototype: @prototype, comment: @comment }
          )
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
