require 'helper'

RSpec.describe RFastRFurious do

  AWESOME_MOVIES = [
    "The Fast and the Furious",
    "2 Fast 2 Furious",
    "The Fast and the Furious: Tokyo Drift",
    "Fast & Furious",
    "Fast Five",
  ]

  UNAWESOME_MOVIES = [
    "The Sorrow and the Pity",
  ]

  describe ".check" do

    context "online" do

      before do
        stub_request(:get, "https://raw.github.com/alunny/r_fast_r_furious/master/fast.js").
          to_return(:body => File.new(File.expand_path("../fixtures/fast.js", __FILE__)))
      end

      AWESOME_MOVIES.each do |title|
        it "is true for \"#{title}\"" do
          expect(RFastRFurious.check(title)).to be_true
        end
      end

      UNAWESOME_MOVIES.each do |title|
        it "is false for \"#{title}\"" do
          expect(RFastRFurious.check(title)).to be_false
        end
      end

    end

    context "offline" do

      before do
        stub_request(:get, "https://raw.github.com/alunny/r_fast_r_furious/master/fast.js").
          to_raise(SocketError)
      end

      AWESOME_MOVIES.each do |title|
        it "is true for \"#{title}\"" do
          expect(RFastRFurious.check(title)).to be_true
        end
      end

      UNAWESOME_MOVIES.each do |title|
        it "is false for \"#{title}\"" do
          expect(RFastRFurious.check(title)).to be_false
        end
      end

    end

  end

end
