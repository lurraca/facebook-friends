require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user_attributes) do
    {
        name: 'Example User',
        email: 'user@example.com'
    }
  end
  let!(:user) { User.create(user_attributes) }

  describe "GET #index" do
    context 'user is logged in'
    xit "returns http success" do
      get :index, nil, { user_id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
