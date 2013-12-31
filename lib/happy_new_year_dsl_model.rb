# encoding: utf-8
require 'active_model'

module HappyNewYear
  class DslModel
    include ActiveModel::Model

    # filename
    attr_accessor :filename
    validates :filename, presence: true

    # newyear letter from(your name)
    attr_accessor :from
    validates :from, presence: true

    # newyear letter common_message
    attr_accessor :common_message
    validates :common_message, presence: true

    # newyear letter tos(target names)
    attr_accessor :tos
    validates :tos, presence: true

    # newyear letter specific_messages(for each target)
    attr_accessor :specific_messages
    validates :specific_messages, presence: true

  end
end
