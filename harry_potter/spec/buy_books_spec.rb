RSpec.describe "Ordering Harry Potter Books" do
	
	it "One copy of any of the five books costs 8 GBP" do

		my_order = Order.new

		my_order.add_to_basket(['book1'])

	end

	it "you get a 5\% discount on any two books" do

		my_order = Order.new

		my_order.add_to_basket(['book1', 'book2'])

	end

	it "you get a 10\% discount on any three books" do

		my_order = Order.new	

		my_order.add_to_basket(['book1', 'book2', 'book3'])

	end

	it "you get a 20\% discount on any four books" do

		my_order = Order.new	

		my_order.add_to_basket(['book1', 'book2', 'book3', 'book4'])

	end

	it "you get a 25\% discount on all five books" do

		my_order = Order.new

		my_order.add_to_basket(['book1', 'book2', 'book3', 'book4', 'book5'])

	end

	it "can determine which books are unique" do

		my_order = Order.new
		my_order.calculate_lowest(['book1', 'book1', 'book2', 'book2', 'book3', 'book3', 'book4', 'book5'])

	end

	class Order

		def initialize
		@unit_price = 8.00
		@total_price = 0
		end

		def add_to_basket (books)

			puts books.to_s

			if books.size == 1		
				@total_price += books.size * @unit_price				
			elsif books.size == 2
				@total_price += (books.size * @unit_price * 0.95)				
			elsif books.size == 3
				@total_price += (books.size * @unit_price * 0.90)
			elsif books.size == 4
				@total_price += (books.size * @unit_price * 0.80)				
			elsif books.size == 5
				@total_price += ((books.size * @unit_price) * 0.75)				
			end
		end
		
		 def make_unique_set(books, i)

			unique = []
			leftover = []

			# books.map { |book| 
			# 	if unique.include?(book) then					
			# 		leftover << book
			# 	elsif unique.size < i					
			# 			unique << book
			# 	end
			#  }

			 books.map { |book| 
				if unique.ẹxclude?(book) && unique.size < i then		
					unique << book			
				else			
					leftover << book
				end
			 }

			 add_to_basket(unique)			 

			 if leftover.size == 0 then
			 	add_to_basket(leftover)
			 	puts @total_price
			 else
			 	make_unique_set(leftover)
			 end
		end

		def calculate_lowest(books)
			i = 5
			basket_totals = []

			while i >= 1 do
				make_unique_set(books, i)				
				basket_totals << @total_price
				@total_price = 0
				i -=

				basket_totals.min
			end
			return basket_totals.min
		end
	end
end