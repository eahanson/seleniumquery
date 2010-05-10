# SeleniumQuery

## Requirements

- Ruby
- Selenium
- jQuery
- webrat?


## Introduction

SeleniumQuery builds a jQuery string and executes it in the browser. It gives
you the jQuery selectors you're used to instead of you having to figure out
how to use Selenium's CSS or Xpath selectors. You can even chain method calls
just like in regular jQuery. 

### Example

This:

    jquery = SeleniumQuery.new(selenium)
    id = jquery.find("td:nth(5).user:visible").closest("tr").attr!("id")
    
executes this in the browser:

    selenium
      .browserbot
      .getCurrentWindow()
      .jQuery(selenium.browserbot.getCurrentWindow().document)
      .find("td:nth(5).user:visible")
      .closest("tr")
      .attr("id")
    
## Usage

Any method you call on the SeleniumQuery object will be converted to a string representing
a Javascript function call and appended to the base command (`selenium.browserbot.getCurrentWindow().jQuery(selenium.browserbot.getCurrentWindow().document)`).

Any method you call that ends in `!` will cause the built-up string to be executed in the browser.
Therefore, your final method call should end in a `!`.

Access attributes with `[]`. This will cause the command to be executed in the browser right away (like `!` does). For example:

    jquery = SeleniumQuery.new(selenium)
    id = jquery.find("div")[:length]
    
is the equivalent of this Javascript:

    $("div").length
    

## FAQ

### Does it handle all jQuery commands?

I doubt it. I'm using it on a small set of tests right now and it works fine.

### What about the `$()` function?

Use `find()` instead.

### It's not working!

Did you end your last method call with a `!`? Do you have exactly one `!`? Are you using `[]` to access
Javascript attributes? 

### What's the argument to the SeleniumQuery constructor?

It expects an instance of webrat's `selenium` class. But all it needs is an object that responds to `get_eval`.

### Where are the tests?

Um, I test drove this by writing some Selenium tests. I should include those here, but I haven't.

### Why are these docs so bad?

I'm tired.
