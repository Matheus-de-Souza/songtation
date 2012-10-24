
class Slide
	attr_accessor :title, :content

	def initialize(title = nil, content = Array.new)
		@title = title
		@content = content
	end
end

class SlideMaker
	def parse(text)
		@slides = Array.new
		text.lines("\r\n") do |line|
			if(line.match(/^#[0-9A-Za-z]+/))
				title = line.sub("\r\n","")
				title = title[1..-1]
				@slides.push(Slide.new(title))
			elsif(@slides.count != 0)
				@slides.last.content.push(line)
			end
		end
		return @slides
	end
end
