module Darknet
  module Weights
    FILE = "yolov3.weights"
    URL = "https://pjreddie.com/media/files/#{FILE}"

    def self.exists?
      File.exist?(file_path)
    end

    def self.file_path
      File.expand_path(FILE, Darknet.dir)
    end

    def self.download
      unless exists?
        # download weights file...
        %x{ wget #{URL} -O #{file_path} }
      end
    end
  end
end
