# license

require 'json'

module Darknet
  class Results < Array
    def self.parse(rows)
      # rows of data like:
      # {"row": 0, "coords": [...], "labels": {"truck": 0.77}}
      # {"row": 1, "coords": [...], "labels": {"car": 0.38, "truck": 0.68}}
      rows = rows.split("\n").collect do |line|
        Result.new JSON.parse line
      end

      # and return result
      self.new rows
    end

    # just limit to labels we want
    def limit_to(labels)
      self
        .collect { |row| row.labels.select { |label, probability| labels.include? label } }
        .select { |row| row.any? }
    end
  end

  class Result
    attr_accessor :labels
    attr_accessor :coords

    def initialize(hash)
      @labels = hash["labels"]
      @coords = hash["coords"]
    end
  end
end
