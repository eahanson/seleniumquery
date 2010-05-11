require 'spec'
require '../selenium_query'

describe "SeleniumQuery" do
  attr_accessor :selenium, :jquery
  
  before do
    @selenium = mock
    @jquery = SeleniumQuery.new(selenium)
  end

  def expect_jquery(s)
    selenium.should_receive(:get_eval).with(SeleniumQuery::BASE_COMMAND + s)
  end
  
  it "can call a jQuery function" do
    expect_jquery %(.find(".foo"))
    jquery.find!(".foo")
  end

  it "can call chained jQuery functions" do
    expect_jquery %(.find(".foo").closest("tr").attr("id"))
    jquery.find(".foo").closest("tr").attr!("id")
  end

  it "can get attributes" do
    expect_jquery %(.find(".foo").length)
    jquery.find(".foo")[:length]
  end

  it "can handle double and single quotes" do
    expect_jquery %(.find(".foo:contains('bar')"))
    jquery.find!(".foo:contains('bar')")
  end

  it "can handle single and double quotes" do
    expect_jquery %(.find('.foo:contains("bar")'))
    jquery.find!('.foo:contains("bar")')
  end

  it "doesn't eval if you don't end with a bang or an attribute" do
    selenium.should_not_receive(:get_eval)
    jquery.find("I forgot a bang")
  end
end