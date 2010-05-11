class SeleniumQuery
  BASE_COMMAND = "selenium.browserbot.getCurrentWindow().jQuery(selenium.browserbot.getCurrentWindow().document)"

  def initialize(selenium)
    @selenium = selenium
    @command = BASE_COMMAND
  end

  def method_missing(symbol, * args)
    if symbol.to_s.match /!$/
      append_to_command(symbol.to_s.gsub(/!$/, ""), args)
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
    arg_string = args.empty? ? "" : args.map do |a|
      quote = a.match(/"/) ? %(') : %(")
      %(#{quote}#{a}#{quote})
    end.join(', ')
    @command += ".#{symbol}(#{arg_string})"
  end
end
