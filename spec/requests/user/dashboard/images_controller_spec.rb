require 'rails_helper'

RSpec.describe User::Dashboard::ImagesController, type: :request do
  describe '#index' do
    context 'logged in' do
      include_context 'sign in user'

      it_behaves_like '200 response', method: :get, path: '/user/dashboard/images'

      it 'renders images page' do
        user.images.attach(
          io: File.open(Rails.root.join('spec', 'factories', 'images', 'meeting.jpeg')),
          filename: 'meeting.jpeg',
          content_type: 'image/jpeg'
        )
        get user_dashboard_images_path
        expect(response.body.downcase).to match('images')
        expect(response.body.downcase).to match('meeting.jpeg')
        is_expected.to render_template(:index)
      end
    end

    context 'not logged in' do
      it_behaves_like 'unanthenticated response', method: :get, path: '/user/dashboard/images'
    end
  end

  describe '#create' do
    shared_examples 'redirects to images page' do
      it 'redirects to images page' do
        post user_dashboard_images_path(user), params: {image: body}
        expect(response.code.to_i).to eq(302)
        follow_redirect!
        expect(response.body.downcase).to match('images')
      end
    end

    context 'logged in' do
      include_context 'sign in user'
      before do
        allow_any_instance_of(ActionDispatch::Request).to receive(:referer).and_return(user_dashboard_accounts_path)
      end

      context 'valid parameters' do
        let(:body) do
          {
            image: fixture_file_upload(File.open(Rails.root.join('spec', 'factories', 'images', 'meeting.jpeg')), 'image/jpeg'),
            name: 'meeting.jpeg'
          }
        end

        it_behaves_like 'redirects to images page'

        it 'changes the password' do
          expect do post user_dashboard_images_path(user), params: {image: body} end.to change { user.images.count }
        end
      end

      # context 'invalid parameters' do
      #   let(:body) do
      #     {current_password: 'password', password: 'password', password_confirmation: 'passwor'}
      #   end
      #
      #   it_behaves_like 'redirects to account page'
      #
      #   # it 'does changes the password' do
      #   #   expect { patch user_dashboard_accounts_path(user), params: {password: body} }.not_to change(user, :encrypted_password)
      #   # end
      # end
    end

    # context 'not logged in' do
    #   let(:user) { FactoryGirl.create(:user) }
    #
    #   it 'redirects to sign in page' do
    #     patch user_dashboard_accounts_path(user), params: {password: body}
    #     expect(response.code.to_i).to eq(401)
    #   end
    # end
  end
end
