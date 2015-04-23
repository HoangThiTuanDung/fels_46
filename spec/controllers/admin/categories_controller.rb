require "rails_helper"

describe Admins::CategoriesController do
  let(:admin) {FactoryGirl.create :admin_user}
  let(:category) {FactoryGirl.create :category}
  let(:valid_attributes) {FactoryGirl.attributes_for :category}
  let(:invalid_attributes) {FactoryGirl.attributes_for :invalid_category}

  before do
    routes.draw do
      namespace :admins do
        resources :categories
      end
    end
    session[:user_id] = admin.id
  end

  describe "GET index" do
    before {get :index}
    subject {response}

    context "responds successfully with an HTTP 200 status code" do
      it {is_expected.to be_success}
      it {is_expected.to have_http_status 200}
    end

    context "renders the index view" do
      it {is_expected.to render_template :index}
    end
  end

  describe "GET show" do
    before {get :show, id: category.id}
    subject {response}

    context "responds successfully with an HTTP 200 status code" do
      it {is_expected.to be_success}
      it {is_expected.to have_http_status 200}
    end

    context "renders the show view" do
      it {is_expected.to render_template :show}
    end
  end

  describe "GET new" do
    before {get :new}
    subject {response}

    context "responds successfully with an HTTP 200 status code" do
      it {is_expected.to be_success}
      it {is_expected.to have_http_status 200}
    end

    context "renders the new view" do
      it {is_expected.to render_template :new}
    end
  end

  describe "GET edit" do
    before {get :edit, id: category.id}
    subject {response}

    context "responds successfully with an HTTP 200 status code" do
      it {is_expected.to be_success}
      it {is_expected.to have_http_status 200}
    end

    context "renders the edit view" do
      it {is_expected.to render_template :edit}
    end
  end

  describe "POST create" do
    describe "with valid attributes" do
      let(:success) {post :create, category: valid_attributes}

      context "creates a new category" do
        it {expect {success}.to change(Category, :count).by 1}
      end

      context "redirects to the new category" do
        before {post :create, category: valid_attributes}
        it {is_expected.to redirect_to admins_category_path Category.last}
      end
    end

    describe "with invalid attributes" do
      let(:fail) {post :create, category: invalid_attributes}

      context "does not save the new category" do
        it {expect {fail}.not_to change(Category, :count)}
      end

      context "re-renders the new method" do
        before {post :create, category: invalid_attributes}
        it {is_expected.to render_template :new}
      end
    end
  end

  describe 'PUT update' do
    describe "with valid attributes" do
      before {put :update, id: category.id, category: FactoryGirl.attributes_for(:update_category)}

      context "change user attributes" do
        subject {category.reload.name}
        it {is_expected.to eq "test_category"}
      end

      context "redirects to category after update" do
        subject {response}
        it {is_expected.to redirect_to admins_category_path category}
      end
    end

    describe "invalid attributes" do
      before {put :update, id: category.id, category: FactoryGirl.attributes_for(:invalid_category)}

      context "change user attributes" do
        subject {category.reload.name}
        it {is_expected.not_to be_nil}
      end

      context "re-renders the edit method" do
        subject {response}
        it {is_expected.to render_template :edit}
      end
    end
  end

  describe 'DELETE destroy' do
    let(:delete_category) {delete :destroy, id: Category.last.id}
    subject {delete_category}

    context "delete a category" do
      it {expect {delete_category}.to change(Category, :count).by -1}
    end

    context "redirects to index" do
      it {is_expected.to redirect_to admins_categories_path}
    end
  end
end