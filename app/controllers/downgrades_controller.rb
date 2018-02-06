class DowngradesController < ApplicationController
  def new
  end
  
  def downgrade_account
    current_user.update_attribute(:role, 0)
    flash[:notice] = "You have successfully downgraded your account."
    redirect_to root_path
  end
end
