require 'rails_helper'

describe 'navigate' do
  before do
    @admin_user = FactoryGirl.create(:admin_user)
    scope = Devise::Mapping.find_scope!(@admin_user)
    login_as(@admin_user, scope: scope)
  end

  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post)
      visit edit_post_path(@post)
    end

    it 'has a status that can be edited on the form by an admin' do
      choose 'post_status_approved'
      click_on 'Save'

      expect(@post.reload.status).to eq('approved')
    end

    it 'cannot be edited by a non admin' do
      logout(:user)
      user = FactoryGirl.create(:user)
      scope = Devise::Mapping.find_scope!(user)
      login_as(user, scope: scope)

      visit edit_post_path(@post)
      expect(page).to_not have_content('Approved')
    end
  end
end