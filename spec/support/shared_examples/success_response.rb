shared_examples '200 response' do |method:, path:|
  it 'returns makes a call and returns 200' do
    send(method, path)
    expect(response.code.to_i).to eq(200)
  end
end