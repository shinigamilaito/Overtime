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

  it 'allows the employee to change the audit log status from the homepage' do
    logout(:user)
    audit_log = FactoryGirl.create(:audit_log)
    user = audit_log.user
    scope = Devise::Mapping.find_scope!(user)
    login_as(user, scope: scope)

    visit root_path
    click_on("confirm_#{audit_log.id}")

    expect(audit_log.reload.status).to eq('confirmed')
  end
end