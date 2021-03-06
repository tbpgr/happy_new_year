# encoding: utf-8
require 'happy_new_year_dsl_model'

module HappyNewYear
  # Dsl
  class Dsl
    attr_accessor :happy_new_year

    # String Define
    [:filename, :from, :common_message].each do |f|
      define_method f do |value|
        @happy_new_year.send("#{f}=", value)
      end
    end

    # Array/Hash/Boolean Define
    [:tos, :specific_messages].each do |f|
      define_method f do |value|
        @happy_new_year.send("#{f}=", value)
      end
    end

    def initialize
      @happy_new_year = HappyNewYear::DslModel.new
      @happy_new_year.filename = 'NewYear'
      @happy_new_year.from = 'your name'
      @happy_new_year.common_message = 'common_message'
      @happy_new_year.tos = ['target name1', 'target name2']
      default_sp_message = ['specific message1', 'specific message2']
      @happy_new_year.specific_messages = default_sp_message
    end
  end
end
