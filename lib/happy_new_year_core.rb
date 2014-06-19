# encoding: utf-8
require 'happy_new_year_dsl'
require 'erb'

# =HappyNewYear
module HappyNewYear
  #  =HappyNewYear Core
  class Core
    # Internal DSL Setting file name
    HAPPY_NEW_YEAR_FILE = 'Happynewyearfile'

    # rubocop:disable LineLength
    # Internal DSL Setting file Template
    HAPPY_NEW_YEAR_TEMPLATE = <<-EOS
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

    EOS
    # rubocop:enable LineLength

    # output html template
    HAPPY_NEW_YEAR_CONTENTS_TEMPLATE = <<-EOS
<html>
<head>
  <meta charset="UTF-8">
  <title>Happy New Year</title>
</head>
<body>
  <marquee style='font-size:40px;'><%=message%></marquee>
</body>
</html>
    EOS

    # basic spacing
    BASIC_SPACE = '     '

    # == generate Happynewyearfile to current directory.
    def init
      File.open(HAPPY_NEW_YEAR_FILE, 'w') { |f|f.puts HAPPY_NEW_YEAR_TEMPLATE }
    end

    # == generate Happy New Year html letters
    def execute
      dsl = read_dsl
      from = dsl.happy_new_year.from
      cmsg = dsl.happy_new_year.common_message
      output_base = dsl.happy_new_year.filename
      dsl.happy_new_year.specific_messages.each_with_index do |smsg, index|
        contents = get_result_html(
          from, cmsg, smsg, dsl.happy_new_year.tos[index])
        output_newyear_html("#{output_base}#{index + 1}.html", contents)
      end
    end

    private

    def read_dsl
      src = File.open(HAPPY_NEW_YEAR_FILE) { |f|f.read }
      dsl = HappyNewYear::Dsl.new
      dsl.instance_eval src
      dsl
    end

    def get_result_html(from, common_message, specific_message, to)
      message = "To #{to}#{BASIC_SPACE}#{common_message}#{BASIC_SPACE}#{specific_message}#{BASIC_SPACE}From #{from}" # rubocop:disable LineLength, UselessAssignment
      erb = ERB.new(HAPPY_NEW_YEAR_CONTENTS_TEMPLATE)
      erb.result(binding)
    end

    def output_newyear_html(filename, contents)
      File.open(filename, 'w:utf-8') { |f|f.print contents }
    end
  end
end
