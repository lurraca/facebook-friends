describe Friend do
  let(:friend) do
    Friend.new(
        {
            "name" => "My Friend",
            "picture" => {
                "data" => {
                    "url" => "/path/top/hoto"
                }
            }
        }
    )
  end

  describe 'validations' do
    it { expect(friend).to be_valid }
  end

end