require 'test/unit'

require './create-site.rb'

class TestSlideCreator < Test::Unit::TestCase

  def setup
    @slides = Array.new
	@slideMaker = SlideMaker.new
  end

  def teardown
	  @slides = nil
	  @slideMaker = nil
  end

  def test_init_with_zero_slides
	assert_equal(0, @slides.count)
  end

  def test_init_with_null_values
	@slides << Slide.new()

	assert_equal( nil, @slides.first.title, "title is not null")
	assert_equal( 0, @slides.first.content.count, "content is not null")
  end

  def test_place_title_without_place_content
	@slides << Slide.new("test")

	assert_not_equal( nil, @slides.first.title, "title is not null")
	assert_equal( 0, @slides.first.content.count, "content is not null")
  end

  def test_place_title_and_content
	@slides << Slide.new("test")

	assert_not_equal( nil, @slides.first.title, "title is not null")
	assert_not_equal( 0, @slides.first.content.count, "content is not null")
  end

  def test_place_title_and_content
	@slides << Slide.new("title", ["content"])

	assert_equal("title", @slides.first.title, "title is not null")
	assert_equal("content", @slides.first.content[0], "content is not null")
  end

  def test_parse_titles
	text = "#titulo1\r\n\r\n\r\n#titulo2"

	@slides.concat( @slideMaker.parse(text) )

	assert_equal(2, @slides.count, @slides)
	assert_equal("titulo1", @slides.first.title)
	assert_equal("titulo2", @slides.last.title)

	assert_equal(2, @slides.first.content.count)
	assert_equal(0,  @slides.last.content.count)
  end

  def test_parse_titles_more_titles
	text = "\r\n\r\n#titulo1\r\n\r\n\r\n#titulo2\r\n#titulo3\r\n\r\n\r\n#titulo4"

	@slides.concat( @slideMaker.parse(text) )

	assert_equal(4, @slides.count)

	assert_equal("titulo1", @slides[0].title)
	assert_equal("titulo2", @slides[1].title)
	assert_equal("titulo3", @slides[2].title)
	assert_equal("titulo4", @slides[3].title)

	assert_equal(2, @slides[0].content.count)
	assert_equal(0, @slides[1].content.count)
	assert_equal(2, @slides[2].content.count)
	assert_equal(0, @slides[3].content.count)
  end

  def test_parse_titles_and_content
	text = "\r\n\r\n#titulo1\r\ncontent\r\n content\r\n#titulo2\r\ncontent"

	@slides.concat( @slideMaker.parse(text) )

	assert_equal(2, @slides.count)

	assert_equal("titulo1", @slides[0].title)
	assert_equal("titulo2", @slides[1].title)

	assert_equal(2, @slides[0].content.count)
	assert_equal(1, @slides[1].content.count)
  end

  def test_get_html_values
	text = "\r\n\r\n#titulo1\r\ncontent\r\ncontent2\r\n#titulo2\r\ncontent"

	@slides.concat( @slideMaker.parse(text) )

	assert_equal(2, @slides.count)

	assert_equal("<h2>titulo1</h2>", @slides[0].getHtmlTitle)
	assert_equal("<h2>titulo2</h2>", @slides[1].getHtmlTitle)

	assert_equal("<p>content<br />content2</p>", @slides[0].getHtmlContent)
	assert_equal("<p>content</p>", @slides[1].getHtmlContent)

	assert_equal("<section><h2>titulo1</h2><p>content<br />content2</p></section>", @slides[0].getFullHtml)
	assert_equal("<section><h2>titulo2</h2><p>content</p></section>", @slides[1].getFullHtml)
  end

  def test_read_text_from_files
	#f = File.open("../song-test.txt", "r");
	#f.lines
  end

  #def setup
    #@calc = Calculator.new
  #end
  #def teardown
	  #@calc = nil
  #end
  #def test_sum
	  #assert_equal(2, @calc.sum(1, 1), "1 + 1 = 2")
  #end
end

