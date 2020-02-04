class UsersController < ApplicationController
  before_action :authenticate_user!, only: :success
  include SidebarData
  def validate_email_uniqueness
    user = User.find_by_email(params[:user][:email])
    status = user.present? ?  :unauthorized : :ok
    respond_to do |format|
      format.json { render json: !user, status: status }
    end
  end

  def forgot_password_authorization
    buyer = Buyer.find_by_email(params[:user][:email])
    status = buyer.present? ? :ok : :unauthorized
    respond_to do |format|
      format.json {render json: buyer.present? ,  status: status}
    end
  end

  def success
  end

  def show
    sidebar_data
    @seller = @sellers.friendly.find(params[:seller_id])
    if @seller.present?
      @items = @items.where(seller_id: @seller.id).order(created_at: :desc).page(params[:page]).per(30)
    end
  end

end
