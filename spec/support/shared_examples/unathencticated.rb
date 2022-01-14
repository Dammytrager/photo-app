shared_examples 'unanthenticated response' do |method:, path:|
  it 'redirects to sign in page' do
    send(method, path)
    expect(response.code.to_i).to eq(302)

    follow_redirect!
    expect(response.code.to_i).to eq(200)
    expect(response.body.downcase).to match('log in')
    expect(response.body.downcase).to match('email')
    expect(response.body.downcase).to match('password')
  end
end