require 'rails_helper'

RSpec.describe WelcomeController, type: :request do
  describe '#index' do

    context 'logged in' do
      include_context 'sign in user'

      it_behaves_like '200 response', method: :get, path: '/'

      it 'renders welcome page and greet user' do
        get root_path
        expect(response.body).to match(user.email)
      end
    end

    context 'not logged in' do

      it_behaves_like '200 response', method: :get, path: '/'

      it 'renders welcome page and shows sign up' do
        get root_path
        expect(response.body.downcase).to match('sign up')
      end
    end
  end
end
