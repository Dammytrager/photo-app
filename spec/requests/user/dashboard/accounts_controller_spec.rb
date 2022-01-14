require 'rails_helper'

RSpec.describe User::Dashboard::AccountsController, type: :request do
  describe '#index' do
    context 'logged in' do
      include_context 'sign in user'

      it_behaves_like '200 response', method: :get, path: '/user/dashboard/accounts'

      it 'renders accounts page' do
        get user_dashboard_accounts_path
        expect(response.body.downcase).to match('change password')
        is_expected.to render_template(:index)
      end
    end

    context 'not logged in' do
      it_behaves_like 'unanthenticated response', method: :get, path: '/user/dashboard/accounts'
    end
  end

  describe '#update' do
    shared_examples 'redirects to account page' do
      it 'redirects to account page' do
        patch user_dashboard_accounts_path(user), params: {password: body}
        expect(response.code.to_i).to eq(302)
        follow_redirect!
        expect(response.body.downcase).to match('change password')
      end
    end

    context 'logged in' do
      include_context 'sign in user'
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:referer).and_return(user_dashboard_accounts_path)
      end

      context 'valid parameters' do
        let(:body) do
          {current_password: 'password', password: 'password_1', password_confirmation: 'password_1'}
        end

        it_behaves_like 'redirects to account page'

        it 'changes the password' do
          expect { patch user_dashboard_accounts_path(user), params: {password: body} }.to change(user, :encrypted_password)
        end
      end

      context 'invalid parameters' do
        let(:body) do
          {current_password: 'password', password: 'password', password_confirmation: 'passwor'}
        end

        it_behaves_like 'redirects to account page'

        # it 'does changes the password' do
        #   expect { patch user_dashboard_accounts_path(user), params: {password: body} }.not_to change(user, :encrypted_password)
        # end
      end
    end

    context 'not logged in' do
      let(:user) { FactoryGirl.create(:user) }

      it 'redirects to sign in page' do
        patch user_dashboard_accounts_path(user), params: {password: body}
        expect(response.code.to_i).to eq(401)
      end
    end
  end
end
