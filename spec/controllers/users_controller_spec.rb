require "rails_helper"

describe UsersController do
  before {routes.draw {resources :users}}

  let(:user) {FactoryGirl.create :user}
  let(:valid_attributes) {FactoryGirl.attributes_for :user}
  let(:invalid_attributes) {FactoryGirl.attributes_for :invalid_user}

  describe "GET show" do
    before {get :show, {id: user.id}}

    subject {response}

    context "responds successfully with an HTTP 200 status code" do
      it {is_expected.to be_success}
      it {is_expected.to have_http_status 200}
    end

    context "renders the show view" do
      it {is_expected.to render_template :show}
    end
  end

  describe "POST create" do
    describe "with valid attributes" do
      let(:success) {post :create, {user: valid_attributes}}

      it "creates a new user" do
        expect {success}.to change(User, :count).by 1
      end

      context "redirects to the new user" do
        before {post :create, {user: valid_attributes}}
        it {is_expected.to redirect_to User.last}
      end
    end

    describe "with invalid attributes" do
      let(:fail) {post :create, {user: invalid_attributes}}

      it "does not save the new user" do
        expect {fail}.not_to change(User, :count)
      end

      context "re-renders the new method" do
        before {post :create, {user: invalid_attributes}}
        it {is_expected.to render_template :new}
      end
    end
  end

  describe 'PUT update' do
    before {session[:user_id] = user.id}

    describe "with valid attributes" do
      before {put :update, id: user.id, user: FactoryGirl.attributes_for(:update_user)}

      context "change user attributes" do
        subject {user.reload.name}
        it {is_expected.to eq "test_user"}
      end

      context "redirects to user after update" do
        subject {response}
        it {is_expected.to redirect_to user}
      end
    end

    describe "invalid attributes" do
      before {put :update, id: user.id, user: FactoryGirl.attributes_for(:invalid_user)}

      context "change user attributes" do
        subject {user.reload.name}
        it {is_expected.not_to be_nil}
      end

      context "re-renders the edit method" do
        subject {response}
        it {is_expected.to render_template :edit}
      end
    end
  end
end