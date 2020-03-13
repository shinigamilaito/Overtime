require 'rails_helper'

describe 'Homepage' do
  before do
    @post = FactoryGirl.create(:post)
  end

  it 'allows the admin to approve posts from the homepage' do
    admin_user = FactoryGirl.create(:admin_user)
    scope = Devise::Mapping.find_scope!(admin_user)
    login_as(admin_user, scope: scope)

    visit root_path

    click_on("approve_#{@post.id}")
    expect(@post.reload.status).to eq('approved')
  end

  it 'non admin user can not approve posts from the homepage' do
    logout(:user)
    non_admin_user = FactoryGirl.create(:user)
    scope = Devise::Mapping.find_scope!(non_admin_user)
    login_as(non_admin_user, scope: scope)

    visit root_path
    click_on("approve_#{@post.id}")
    expect(@post.reload.status).to eq('submitted')
  end
end