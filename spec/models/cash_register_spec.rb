require "rails_helper"

RSpec.describe CashRegister, :type => :model do

	before do
		@cash_register = CashRegister.new
	end

  context "with 2 or more comments" do
    it "orders them in reverse chronologically" do
      #post = Post.create!
      #comment1 = post.comments.create!(:body => "first comment")
      #comment2 = post.comments.create!(:body => "second comment")
      binding.pry
      #expect(post.reload.comments).to eq([comment2, comment1])
    end
  end
end