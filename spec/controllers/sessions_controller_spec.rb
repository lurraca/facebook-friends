require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user_attributes) do
    {
        name: 'Example User',
        email: 'user@example.com'
    }
  end
  let!(:user) { User.create(user_attributes) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #facebook_login" do
    it "redirect to login" do
      get :facebook_login
      expect(response).to have_http_status(:redirect)
    end
  end

  describe '#GET #callback' do
    context 'no auth code' do
      it 'redirect to /login' do
        get :callback
        expect(response).to redirect_to('/login')
      end
    end

    xcontext 'auth code' do
      it 'grants login to the application' do
        get :callback
      end
    end
  end

