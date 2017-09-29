require 'weather'

RSpec.describe "find day with smallest speard" do

	it "can day with smallest spread" do

		my_data = Weather.new

		expect(my_data.find("weather.dat")).to eq(["14",2])
	end
end
