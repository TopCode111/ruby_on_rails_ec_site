module CommonItemComment
  def self.default_config(&block)
    proc{
      controller do

        def scoped_collection
          @item = Item.friendly.find(params[:item_id])
          @comment = @item.root_comments
        end
      end
    instance_exec(&block) if block_given?
  }
  end
end
