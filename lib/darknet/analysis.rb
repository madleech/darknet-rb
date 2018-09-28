module Darknet
  class Analysis
    def initialize(filename, threshold: 0.25)
      @filename = filename
      @threshold = threshold
      # filename needs to be absolute
      unless @filename.start_with? '/'
        @filename = File.expand_path(@filename, Dir.pwd)
      end
    end

    # runs darknet detector, trashing debug output on stderr and then processing the result
    def run
      Darknet::Weights.download
      Results.parse %x{ cd #{Darknet.dir} && ./darknet detect cfg/yolov3.cfg #{Darknet::Weights::FILE} #{@filename} -thresh #{@threshold} }
    end
  end
end
