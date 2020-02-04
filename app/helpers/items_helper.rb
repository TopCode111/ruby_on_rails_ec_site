module ItemsHelper
  def selected_category(category_name)
    @selected_categories = Category.find_by_title(category_name)
  end
end
