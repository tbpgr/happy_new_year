# HappyNewYear

[![Gem Version](https://badge.fury.io/rb/happy_new_year.svg)](http://badge.fury.io/rb/happy_new_year)

HappyNewYear generates 'happy new year html-letters'.

## Purpose
* Send new year messages by html-marquee.

## Installation

Add this line to your application's Gemfile:

    gem 'happy_new_year'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install happy_new_year

## Usage
### init setting file(Happynewyearfile)
~~~bash
happynewyear init
~~~

Happynewyearfile
~~~ruby
# encoding: utf-8

# filename
# filename is required
# filename allow only String
# filename's default value => "NewYear"
filename "NewYear"

# newyear letter from(your name)
# from is required
# from allow only String
# from's default value => "your name"
from "your name"

# newyear letter common_message
# common_message is required
# common_message allow only String
# common_message's default value => "common_message"
common_message "common_message"

# newyear letter tos(target names)
# tos is required
# tos allow only Array
# tos's default value => ["target name1", "target name2"]
tos ["target name1", "target name2"]

# newyear letter specific_messages(for each target)
# specific_messages is required
# specific_messages allow only Array
# specific_messages's default value => ["specific message1", "specific message2"]
specific_messages ["specific message1", "specific message2"]
~~~

### edit setting file(Happynewyearfile) manually
Happynewyearfile
~~~ruby
# encoding: utf-8
filename "NewYear"
from "tbpgr"
common_message "Happy New Year!!"
tos ["Mr tanaka kazuo", "Mr suzuki ichiro"]
specific_messages ["The best regards next year.", "In fact I love you."]
~~~

### output happy new year html-letter
~~~bash
happynewyear execute
~~~

### comfirm output html files
* NewYear1.html
~~~html
<html>
<head>
  <meta charset="UTF-8">
  <title>Happy New Year</title>
</head>
<body>
  <marquee style='font-size:40px;'>To Mr tanaka kazuo     Happy New Year!!     The best regards next year.     From tbpgr</marquee>
</body>
</html>
~~~

* NewYear2.html
~~~html
<html>
<head>
  <meta charset="UTF-8">
  <title>Happy New Year</title>
</head>
<body>
  <marquee style='font-size:40px;'>To Mr suzuki ichiro     Happy New Year!!     In fact I love you.     From tbpgr</marquee>
</body>
</html>
~~~

## History
* version 0.0.2 : fix runtime-dependency.
* version 0.0.1 : first release.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
