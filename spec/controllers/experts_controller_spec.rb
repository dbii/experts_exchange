require 'rails_helper'

RSpec.describe ExpertsController, type: :controller do

  let(:expert) { create :expert }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: expert.to_param}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: {}
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: {id: expert.to_param}
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update, params: {id: expert.to_param}
      expect(response).to have_http_status(:redirect)
    end
  end

end
