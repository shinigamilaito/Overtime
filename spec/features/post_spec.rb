require 'rails_helper'

describe 'navigate' do
  before do
    @user = FactoryGirl.create(:user)
    scope = Devise::Mapping.find_scope!(@user)
    login_as(@user, scope: scope)
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      FactoryGirl.build_stubbed(:post)
      FactoryGirl.build_stubbed(:second_post)
      visit posts_path
      expect(page).to have_content(/Rationale|content/)
    end

    it 'has a scope so that only post creators can see their posts' do
      post1 = Post.create(date: Date.today, rationale: "asdf", user_id: @user.id)
      post2 = Post.create(date: Date.today, rationale: "asdf", user_id: @user.id)

      other_user = FactoryGirl.create(:non_authorized_user)
      post_from_other_user = Post.create(date: Date.today, rationale: "This post shouldn't be seen", user_id: other_user.id)

      visit posts_path

      expect(page).to_not have_content(/This post shouldn't be seen/)
    end
  end

  describe 'new' do
    it 'has a link from the homepage' do
      visit root_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      post = FactoryGirl.create(:post)
      # TODO refactor
      post.update(user_id: @user.id)
      visit posts_path

      click_link("delete_post_#{post.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"

      click_on "Save"

      expect(page).to have_content("Some rationale")
    end

    it 'will have a user associated it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User Association"

      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("User Association")
    end
  end

  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post)
      @post.update(user_id: @user.id)
    end

    it 'can be reached by clicking edit on index page' do
      visit posts_path

      click_link("edit_post_#{@post.id}")
      expect(page.status_code).to eq(200)
    end

    it "can be edited" do
      logout(:user)
      user = @post.user
      scope = Devise::Mapping.find_scope!(user)
      login_as(user, scope: scope)
      visit edit_post_path(@post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'Edited content'
      click_on 'Save'

      expect(page).to have_content("Edited content")
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      non_authorized_user = FactoryGirl.create(:non_authorized_user)
      scope = Devise::Mapping.find_scope!(non_authorized_user)
      login_as(non_authorized_user, scope: scope)

      visit edit_post_path(@post)
      expect(current_path).to eq(root_path)
    end
  end
end