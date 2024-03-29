
class Slide
	attr_accessor :title, :content

	def initialize(title = nil, content = Array.new)
		@title = title
		@content = content
	end
	def getHtmlTitle
		return "<h2>" + @title + "</h2>"
	end
	def getHtmlContent
		result = ""
		content.each{ |x| result.concat(x + "<br />") }
		if(result.length != 0)
			result = result[0..-7]
		end
		return "<p>" + result + "</p>"
	end

	def getFullHtml
		return "<section>" + getHtmlTitle() + getHtmlContent() + "</section>"
	end
end

class SlideMaker
	def parseString(text)
		@slides = Array.new

		if(text.include?("\r\n"))
			text.gsub!("\r","")
		elsif(text.include?("\r"))
			text.gsub!("\r","\n")
		end

		text.lines("\n") do |line|
			if(line.match(/^#[0-9A-Za-z]+/))
				title = line.sub("\n","")
				title = title[1..-1]
				@slides.push(Slide.new(title))
			elsif(@slides.count != 0)
				line = line.sub("\n","")
				@slides.last.content.push(line)
			end
		end
		return @slides
	end
	def parseFile(filepath)
		f = File.open(filepath, "r")
		return parseString(f.read)
	end
end
