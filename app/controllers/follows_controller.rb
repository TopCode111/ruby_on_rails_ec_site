class FollowsController < ApplicationController
  before_action :authenticate_user!

  def follow
    sidebar_data
    @seller = @sellers.friendly.find(params[:id])
    current_user.follow(@seller)
    respond_to do |format|
      format.html {render layout: false}
      format.js {render layout: false}
    end
  end

  def unfollow
    sidebar_data
    @seller = @sellers.friendly.find(params[:id])
    current_user.stop_following(@seller)
    respond_to do |format|
      format.html {render layout: false}
      format.js {render layout: false}
    end
  end

  def followings
    sidebar_data
    ids = current_user.all_following.compact.pluck(:id)
    @followings = @sellers.where(id: ids)
    @related_sellers = @sellers.where.not(id: @followings.map(&:id)).limit(5) if @followings.present?
    @related_items = @items.where(seller_id: @related_sellers.map(&:id)).order(created_at: :desc).limit(5) if @followings.present?
    @items = @items.where(seller_id: @followings.map(&:id)).order(created_at: :desc)
  end
end
