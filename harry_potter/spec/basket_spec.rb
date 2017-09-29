require 'basket'
RSpec.describe Basket do
  {
    [1] => 800,
    [1, 2] => 1520,
    [1, 2, 3] => 2160,
    [1, 2, 3, 4] => 2560,
    [1, 2, 3, 4 ,5] => 3000,
    [1, 1] => 1600,
    [1, 1, 2] => 2320,
    [1, 1, 2, 3] => 2960,
    [1, 1, 2, 2, 3, 3, 4, 5] => 5120,
  }.each do |books, expected|
    it "calculates example #{books.inspect}" do
      expect(subject.total(books)).to eq(expected)
    end
  end
end
