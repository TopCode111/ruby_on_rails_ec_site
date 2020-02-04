ActiveAdmin.register Comment, as: 'UserComments', namespace: :seller_admins do
  menu label: 'コメント', priority: 3
  actions :all, except: [:new, :edit, :update, :show]

  breadcrumb do
   [
     link_to(t('Comment'), seller_admins_user_comments_path)
   ]   
  end

  index do
    column :id
    column t('Item Name'), :commentable
    column :user
    column :body
    actions defaults: true do |comment|
      if comment.has_children?
        link_to t("Reply")+'('+comment.children.count.to_s+")", new_thread_path(comment), class: 'member_link'
      else
        link_to t("Reply"), new_thread_path(comment), class: 'member_link'
      end
    end
  end

  controller do
    def scoped_collection
      seller_items_ids = Item.where(seller: current_seller_admin.seller).map(&:id)
      Comment.where(commentable_id: seller_items_ids).where(parent_id: nil)
    end

    def create_thread
      @comment = Comment.find(params[:id])
      @item = @comment.commentable
      @new_thread = Comment.build_from(@item, current_seller_admin.seller.id, params[:user_comment][:body])
      @new_thread.save!
      @new_thread.move_to_child_of(@comment)
      redirect_to new_thread_path(@comment)
    end

    def new_threads
      @comment = Comment.find(params[:id])
      @item = @comment.commentable
    end
  end
end