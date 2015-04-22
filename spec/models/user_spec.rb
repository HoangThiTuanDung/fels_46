require "rails_helper"

describe User do
  let(:user) {FactoryGirl.create :user}
  let(:other_user) {FactoryGirl.create :user, role: 1}

  subject {user}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:role)}

  describe "validation user" do
    context "has a valid factory" do
      it {is_expected.to be_valid}
    end

    context "when name is not present" do
      before {subject.name = ""}
      it {is_expected.not_to be_valid}
    end

    context "when name is too long" do
      before {subject.name = Faker::Lorem.characters(55)}
      it {is_expected.not_to be_valid}
    end

    context "when email is not present" do
      before {subject.email = ""}
      it {is_expected.not_to be_valid}
    end

    context "when email is not unique" do
      subject {other_user}
      before {subject.email = user[:email]}
      it {is_expected.not_to be_valid}
    end

    context "when password is not present" do
      before {subject.password = subject.password_confirmation = ""}
      it {is_expected.not_to be_valid}
    end

    context "when password is too short" do
      before {subject.password = Faker::Lorem.characters(4)}
      it {is_expected.not_to be_valid}
    end

    describe "when password does not match confirmation" do
      before {subject.password_confirmation = "mismatch"}
      it {is_expected.not_to be_valid}
    end
  end

  describe "check admin user" do
    context "when user is admin" do
      subject {other_user.role}
      it {is_expected.to eq 1}
    end

    context "when user is not admin" do
      subject {user.role}
      it {is_expected.not_to eq 1}
    end
  end
end
