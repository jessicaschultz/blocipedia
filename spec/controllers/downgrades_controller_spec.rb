require 'rails_helper'

RSpec.describe DowngradesController, type: :controller do

  describe "GET #downgrade_account" do
    it "returns http success" do
      get :downgrade_account
      expect(response).to have_http_status(:success)
    end
  end

end
