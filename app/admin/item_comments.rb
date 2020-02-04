ActiveAdmin.register Comment, as: 'ItemComments', &CommonItemComment.default_config{
  menu false
  belongs_to :item
  actions :all, except: [:new, :edit, :update, :show]

  breadcrumb do
    if params[:action]=='new_threads'
      [
        link_to(t('Comment'), admin_item_item_comments_path(item))
      ]
    else
      [
        link_to(item.name, admin_item_path(item))
      ]
    end   
  end

  index do
    column :id
    column :user
    column :body
    actions defaults: true do |comment|
      if comment.has_children?
        link_to t("Reply")+ '('+comment.children.count.to_s+')', item_new_thread_path(comment), class: 'member_link'
      else
        link_to t("Reply"), item_new_thread_path(comment), class: 'member_link'
      end
    end
  end

  controller do

    def create_comment_thread
      @comment = Comment.find(params[:id])
      @item = @comment.commentable
      @new_thread = Comment.build_from(@item, params[:item_comment][:user_id], params[:item_comment][:body])
      @new_thread.save!
      @new_thread.move_to_child_of(@comment)
      redirect_to item_new_thread_path(@comment)
    end

    def new_threads
      @comment = Comment.find(params[:id])
      @item = @comment.commentable
    end
  end
}

ActiveAdmin.register Comment, as: 'ItemComments', namespace: :seller_admins, &CommonItemComment.default_config{
  menu false
  belongs_to :item
  actions :all, except: [:new, :edit, :update, :show]

  index do
    column :id
    column :user
    column :body
    actions defaults: true do |comment|
      if comment.has_children?
        link_to t("Reply")+ '('+comment.children.count.to_s+')', new_thread_path(comment), class: 'member_link'
      else
        link_to t("Reply"), new_thread_path(comment), class: 'member_link'
      end
    end
  end
}