require "rails_helper"
require "support/factory_girl"
require "devise"

RSpec.describe  TransactionsController, :type => :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end
  describe "responds to" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @admin = FactoryGirl.create(:user)
      sign_in :user, @admin # sign_in(scope, resource)
    end
    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource){ nil } }
    it "responds to html by default" do
      post :create, { :transaction => {:transaction_description =>" My first ever expense" , :amount_spent => 90 , :transaction_type => "home expense" }}
      expect(response.content_type).to eq "text/html"
    end

    it "returns transaction" do
      post :create, { :transaction => {:transaction_description =>" My first ever expense" , :amount_spent => 90 , :transaction_type => "home expense" }}
      @transaction_user = Transaction.first.user_id
      expect(@transaction_user).to eq @admin.id
    end

    it "checks for Payworker /Sidekick for job enque" do
      post :create, { :transaction => {:transaction_description =>" My first ever expense" , :amount_spent => 90 , :transaction_type => "home expense" }}
      @transaction_user = Transaction.first.user_id
      expect {
        PaybackUpdateWorker.perform_async(@transaction_user)
      }.to change(PaybackUpdateWorker.jobs, :size).by(1)
    end

  end

end
