class UserController < ApplicationController
  respond_to :json
  
  def get_users
    @all_users = User.where.not(id: current_user.id)
    respond_with(@all_users) do |format|
      format.json { render partial: "users/users.json" }
    end
  end
end
