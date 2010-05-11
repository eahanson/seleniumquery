# SeleniumQuery

[http://github.com/eahanson/seleniumquery](http://github.com/eahanson/seleniumquery)

## Introduction

SeleniumQuery makes Selenium testing in Ruby a little easier by helping you
build a jQuery string that can be executed in the browser during a test. The
goal is to let you create selectors in jQuery rather than using Selenium's
limited built-in CSS or XPath selectors.

## Requirements

- Ruby
- Selenium
- jQuery

### Example

This:

    # this is ruby
    jquery = SeleniumQuery.new(selenium)
    id = jquery.find("td:nth(5).user:visible").closest("tr").attr!("id")
    
executes this in the browser:

    // this is Javascript
    selenium
      .browserbot
      .getCurrentWindow()
      .jQuery(selenium.browserbot.getCurrentWindow().document)
      .find("td:nth(5).user:visible")
      .closest("tr")
      .attr("id");
    
## Usage

Any method you call on the SeleniumQuery object will be converted to a string representing
a Javascript function call and appended to the base command
(`selenium.browserbot.getCurrentWindow().jQuery(selenium.browserbot.getCurrentWindow().document)`).

Any method you call that ends in `!` will cause the built-up string to be executed in the browser.
Therefore, your final method call should end in a `!`.

Access attributes with `[]`. This will cause the command to be executed in the browser right away (like `!` does). For example:

    jquery = SeleniumQuery.new(selenium)
    id = jquery.find("div")[:length]
    
is the equivalent of this Javascript:

    $("div").length;
    

## FAQ

### How well does this work?

It works great on the small set of Selenium tests I have on one project. There are most likely issues.
Patches (with tests) are appreciated.

### What about the `$()` function?

Use `find()` instead.

### It's not working!

- Make sure your last method call ends with a `!` (or is an attribute).
- Make sure you have only one `!`.
- Use `[]` to access Javascript attributes, rather than `.` (e.g., `[:length]` rather than `.length`)

### What's the argument to the SeleniumQuery constructor?

It expects an object that responds to `get_eval`.

### License?

Licensed under the [MIT license](http://www.opensource.org/licenses/mit-license.php)