class Weather

	def find(file)
		lines = read_file(file)
		lines = delete_unneeded_lines(lines)
		split_array = split_lines(lines)
		spread = Hash.new
		split_array.each{|line| spread[line[0]] = (line[1].to_i-line[2].to_i).abs}
		spread.sort_by { |key, value| value }.first
	end

	def read_file(file)
		File.readlines("./lib/#{file}")
	end

	def delete_unneeded_lines(ln)
		ln.delete_at(0)
		ln.delete_at(0)
		ln.delete_at(30)
		return ln
	end

	def split_lines(lns)
		arr = []
		lns.each {|line| arr << line.gsub(/\s+/m, ' ').strip.split(" ")}
		return arr
	end
end
