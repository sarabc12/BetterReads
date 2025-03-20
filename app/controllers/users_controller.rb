class UsersController < ApplicationController
  def dashboard
    @lists = current_user.lists
    authorize current_user
  end
end
