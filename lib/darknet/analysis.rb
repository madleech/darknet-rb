require 'shellwords'
require 'open3'

module Darknet
  class Analysis
    attr_accessor :dir
    attr_accessor :threshold
    attr_accessor :data_file
    attr_accessor :config_file
    attr_accessor :weights_file

    def initialize(filename, dir: Darknet.dir, threshold: 0.25, data_file: 'cfg/coco.data', config_file: 'cfg/yolov3.cfg', weights_file: Darknet::Weights::FILE)
      @filename = filename
      @dir = dir
      @threshold = threshold
      @data_file = data_file
      @config_file = config_file
      @weights_file = weights_file

      # filename needs to be absolute
      unless @filename.start_with? '/'
        @filename = File.expand_path(@filename, Dir.pwd)
      end
    end

    # runs darknet detector, trashing debug output on stderr and then processing the result
    def run
      # check files exist
      [weights_file, config_file].each do |file|
        raise "Missing file: #{file}" unless File.exist? file
      end

      # run analysis
      Open3.popen3("#{Darknet.dir}/darknet", 'detector', 'test', data_file, config_file, weights_file, @filename, '-thresh', @threshold.to_s, chdir: dir) do |stdin, stdout, stderr, wait|
        # check response code
        if wait.value.exitstatus.zero?
          Results.parse stdout.read
        else
          raise "Error executing darknet: #{stderr.read}"
        end
      end
    end
  end
end
