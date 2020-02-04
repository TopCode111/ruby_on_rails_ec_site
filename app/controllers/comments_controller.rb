class CommentsController < ApplicationController
  before_action :authenticate_user!, except: :comment_threads
    
  def create
    sidebar_data
    @item = @items.friendly.find(params[:item_id])
    @comment = Comment.build_from(@item, current_user.id, params[:comment])
    @comment.save!
    @all_comments = @item.root_comments.order(created_at: :desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html {render nothing}
      format.js {render layout: false}
    end
  end

  def create_thread
    sidebar_data
    @item = @items.friendly.find(params[:item_id])
    @comment = Comment.find(params[:comment_id])
    @new_thread = Comment.build_from(@item, current_user.id, params[:comment])
    @new_thread.save!
    @new_thread.move_to_child_of(@comment);
    @all_comments = @item.root_comments.order(created_at: :desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html {render nothing}
      format.js {render layout: false}
    end
  end

  def comment_threads
    @comment = Comment.find(params[:id])
    @page = params[:page]
    @all_comments = @comment.commentable.root_comments.order(created_at: :desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html {render nothing}
      format.js {render layout: false}
    end
  end
end
