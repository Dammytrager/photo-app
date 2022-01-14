require 'rails_helper'

RSpec.describe User::Dashboard::HomeController, type: :request do
  describe '#index' do

    context 'logged in' do
      include_context 'sign in user'

      it_behaves_like '200 response', method: :get, path: '/user/dashboard'

      it 'dashboard home' do
        get user_dashboard_root_path
        expect(response.body.downcase).to match('sign out')
        expect(response.body.downcase).to match('account')
      end
    end

    context 'not logged in' do
      it_behaves_like 'unanthenticated response', method: :get, path: '/user/dashboard'
    end
  end
end
