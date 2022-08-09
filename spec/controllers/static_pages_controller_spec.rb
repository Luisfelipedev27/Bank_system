require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #root" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

end
