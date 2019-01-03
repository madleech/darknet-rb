# license

require 'json'

module Darknet
  class Results < Array
    def self.parse(rows)
      # rows of data like:
      # RV: 94%	(left_x:  925   top_y:  587   width:   34   height:   21)
      # RV: 100%	(left_x: 1148   top_y:  600   width:   37   height:   28)
      rows = rows.split("\n").collect do |line|
        line.match(/(.*):[\s]*([\d]+)%[\s]*\(left_x:[\s]*([\d]+)[\s]*top_y:[\s]*([\d]+)[\s]*width:[\s]*([\d]+)[\s]*height:[\s]*([\d]+)\)/) do |match|
          Result.new(
            label: match[1],
            confidence: match[2].to_f / 100,
            left: match[3].to_i,
            top: match[4].to_i,
            width: match[5].to_i,
            height: match[6].to_i,
          )
        end
      end

      # and return result
      self.new rows.compact
    end

    # just limit to labels we want
    def limit_to(labels)
      self.select { |row| labels.include?(row.label).any? }
    end
  end

  class Result
    attr_accessor :label
    attr_accessor :confidence
    attr_accessor :left
    attr_accessor :top
    attr_accessor :width
    attr_accessor :height

    def initialize(label:, confidence:, left:, top:, width:, height:)
      @label = label
      @confidence = confidence
      @left = left
      @top = top
      @width = width
      @height = height
    end
  end
end
