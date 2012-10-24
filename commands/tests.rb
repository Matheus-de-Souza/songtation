require 'test/unit'

require './create-site.rb'

class TestSlideCreator < Test::Unit::TestCase

  def setup
    @slides = Array.new
  end

  def teardown
	  @slides = nil
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

	slideMaker = SlideMaker.new

	@slides.concat( slideMaker.parse(text) )

	assert_equal(2, @slides.count, @slides)
	assert_equal("titulo1", @slides.first.title)
	assert_equal("titulo2", @slides.last.title)

	assert_equal(2, @slides.first.content.count)
	assert_equal(0,  @slides.last.content.count)
  end

  def test_parse_titles_more_titles
	text = "\r\n\r\n#titulo1\r\n\r\n\r\n#titulo2\r\n#titulo3\r\n\r\n\r\n#titulo4"

	slideMaker = SlideMaker.new

	@slides.concat( slideMaker.parse(text) )

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

	slideMaker = SlideMaker.new

	@slides.concat( slideMaker.parse(text) )

	assert_equal(2, @slides.count)

	assert_equal("titulo1", @slides[0].title)
	assert_equal("titulo2", @slides[1].title)

	assert_equal(2, @slides[0].content.count)
	assert_equal(1, @slides[1].content.count)
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

