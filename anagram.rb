class Anagrams
	def self.are_anagrams?(string1,string2)
		if string1.size==string2.size
		   if string1.chars.sort_by(&:downcase).join==string2.chars.sort_by(&:downcase).join
		   	 	puts "Strings are Anagrams"
		   	 	return
		   end
		end

		puts "Strings are not Anagrams"
	end
end

Anagrams.are_anagrams?(ARGV[0],ARGV[1])