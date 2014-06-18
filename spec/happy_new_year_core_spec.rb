# encoding: utf-8
require 'spec_helper'
require 'happy_new_year_core'

describe HappyNewYear::Core do

  context :init do
    OUTPUT_DSL_TMP_DIR = 'generate_dsl'
    cases = [
      {
        case_no: 1,
        case_title: 'valid new year mail',
        expected: HappyNewYear::Core::HAPPY_NEW_YEAR_TEMPLATE,
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          happy_new_year_core = HappyNewYear::Core.new

          # -- when --
          happy_new_year_core.init

          # -- then --
          actual = File.read("./#{HappyNewYear::Core::HAPPY_NEW_YEAR_FILE}")
          expect(actual).to eq(c[:expected])
        ensure
          case_after c

        end
      end

      def case_before(c)
        Dir.mkdir(OUTPUT_DSL_TMP_DIR) unless Dir.exist? OUTPUT_DSL_TMP_DIR
        Dir.chdir(OUTPUT_DSL_TMP_DIR)
      end

      def case_after(c)
        Dir.chdir('../')
        FileUtils.rm_rf(OUTPUT_DSL_TMP_DIR) if Dir.exist? OUTPUT_DSL_TMP_DIR
      end
    end
  end

  context :execute do
    OUTPUT_TMP_DIR = 'tmp_newyear'
    NEWYEAR_CASE1_INPUT = <<-EOS
# encoding: utf-8
filename "HappyNewYear"
from "tbpgr"
common_message "A Happy New Year!!"
tos ["Mr tanaka hiroshi", "Mr suzuki kazuo"]
specific_messages ["The best regards next year.", "In fact I love you."]
    EOS

    NEWYEAR_OUTPUTS1_1 = <<-EOS
<html>
<head>
  <meta charset="UTF-8">
  <title>Happy New Year</title>
</head>
<body>
  <marquee style='font-size:40px;'>To Mr tanaka hiroshi     A Happy New Year!!     The best regards next year.     From tbpgr</marquee>
</body>
</html>
    EOS

    NEWYEAR_OUTPUTS1_2 = <<-EOS
<html>
<head>
  <meta charset="UTF-8">
  <title>Happy New Year</title>
</head>
<body>
  <marquee style='font-size:40px;'>To Mr suzuki kazuo     A Happy New Year!!     In fact I love you.     From tbpgr</marquee>
</body>
</html>
    EOS

    cases = [
      {
        case_no: 1,
        case_title: 'valid new year output',
        input: NEWYEAR_CASE1_INPUT,
        expected_file_names: ['HappyNewYear1.html', 'HappyNewYear2.html'],
        expected_file_contents: [NEWYEAR_OUTPUTS1_1, NEWYEAR_OUTPUTS1_2],
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          happy_new_year_core = HappyNewYear::Core.new

          # -- when --
          happy_new_year_core.execute

          # -- then --
          c[:expected_file_names].each_with_index do |filename, index|
            file_exists = File.exist?(filename)
            expect(file_exists).to be_true
            file_contents = File.read(filename)
            expect(file_contents).to eq(c[:expected_file_contents][index])
          end
        ensure
          case_after c
        end
      end

      def case_before(c)
        Dir.mkdir(OUTPUT_DSL_TMP_DIR) unless Dir.exist? OUTPUT_DSL_TMP_DIR
        Dir.chdir(OUTPUT_DSL_TMP_DIR)
        File.open(HappyNewYear::Core::HAPPY_NEW_YEAR_FILE, 'w:utf-8') { |f|f.print c[:input] }
      end

      def case_after(c)
        Dir.chdir('../')
        FileUtils.rm_rf(OUTPUT_DSL_TMP_DIR) if Dir.exist? OUTPUT_DSL_TMP_DIR
      end
    end
  end

end
