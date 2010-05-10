class SeleniumQuery
  def initialize(selenium)
    @selenium = selenium
    @command = "selenium.browserbot.getCurrentWindow().jQuery(selenium.browserbot.getCurrentWindow().document)"
  end

  def method_missing(symbol, * args)
    if symbol.to_s.end_with?("!")
      append_to_command(symbol.to_s.gsub(/!/, ""), args)
      get_eval
    else
      append_to_command(symbol, args)
      self
    end
  end

  def [](attr)
    @command += ".#{attr}"
    get_eval
  end

  def get_eval
    @selenium.get_eval(@command)
  end

  def to_s
    get_eval
  end

  protected

  def append_to_command(symbol, args)
    arg_string = args.empty? ? "" : args.map { |a| %("#{a}") }.join(', ')
    @command += ".#{symbol}(#{arg_string})"
  end
end
