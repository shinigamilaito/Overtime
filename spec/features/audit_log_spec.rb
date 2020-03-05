require 'rails_helper'

describe 'AuditLog Feature' do
  describe 'index' do
    before do
      admin_user = FactoryGirl.create(:admin_user)
      scope = Devise::Mapping.find_scope!(admin_user)
      login_as(admin_user, scope: scope)
      FactoryGirl.create(:audit_log)
    end

    it 'has a index page that can be reached' do
      visit audit_logs_path
      expect(page.status_code).to eq(200)
    end

    it 'renders audit log content' do
      visit audit_logs_path
      expect(page).to have_content(/SNOW, JOHN/)
    end

    it 'cannot be accessed by non admin users' do
      logout(:user)
      user = FactoryGirl.create(:user)
      scope = Devise::Mapping.find_scope!(user)
      login_as(user, scope: scope)

      visit audit_logs_path
      expect(current_path).to eq(root_path)
    end
  end
end