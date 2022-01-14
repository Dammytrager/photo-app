shared_context 'sign in user' do
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
  end
end