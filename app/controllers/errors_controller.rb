class ErrorsController < ApplicationController
  def not_found
    sidebar_data
    render status: 404
  end

  def internal_server_error
    sidebar_data
    render status: 500
  end
end
