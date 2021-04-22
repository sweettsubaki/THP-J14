require_relative '../lib/dark_trader'
require "nokogiri"
require "open-uri"


describe "content values" do
    it "test" do
        expect(contentName()).to eq(contentPrice)
      end
    end
