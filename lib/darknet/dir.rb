# where to find the darknet code
module Darknet
  def self.dir
    File.expand_path("../../darknet-#{VERSION}", __dir__)
  end
end
