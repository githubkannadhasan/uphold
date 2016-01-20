module Uphold
  module Transports
    class Local < Transport
      def initialize(params)
        @dir = params[:dir]
        @path = params[:path]
        @folder = params[:folder]
      end

      def fetch_backup
        if File.file?(@path)
          tmp_path = File.join(@dir, File.basename(@path))
          logger.debug "Copying '#{@path}' to '#{tmp_path}'"
          FileUtils.cp(@path, tmp_path)
          logger.debug "Decompressing '#{File.basename(tmp_path)}'"
          decompress(tmp_path) do |_b|
          end
          logger.debug 'Done with transport'
          File.join(@dir, @folder)
        else
          logger.fatal "No file exists at '#{@path}'"
        end
      end

    end
  end
end
