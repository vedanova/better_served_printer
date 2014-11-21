require 'yaml'
module BetterServedPrinter
  class Printer
    REQUIRED_CONFIGURATION = [:api_key, :account]
    attr_accessor :config

    def initialize
      @config = BetterServedPrinter.configuration
      @logger = BetterServedPrinter.logger
      @log_level = config.log_level
      check_configuration
      setup_printer
      self
    end

    def connect
      connection = BetterServedPrinter::Connection.new(self, @config)
      connection.subscribe
    end


    # takes a hash
    # * message_format: (raw|html)
    # * message
    def print(msg)
      message = msg['message']
      @logger.debug("Printing msg #{message}")
      print_raw(message)
    end

    def print_raw(msg)
      File.open(@port, 'wb') do |p|
        p.write(msg); p.flush
      end
    end

    private

    def get_port
      @port ||= case
                  when File.exist?("/dev/usb/lp1")
                    "/dev/usb/lp1"
                  when File.exist?("/dev/usb/lp2")
                    "/dev/usb/lp2"
                  when File.exist?("/dev/usb/lp3")
                    "/dev/usb/lp3"
                  when File.exist?("/dev/usb/lp4")
                    "/dev/usb/lp4"
                  else
                    "LPT1:"
                end
      @logger.info "Printing to port #{@port}"
    end

    def setup_printer
      get_port
    end

    def check_configuration
      config = REQUIRED_CONFIGURATION.map {|c| @config.send(c)}
      raise "#{REQUIRED_CONFIGURATION.join(', ')} are required" if config.include?(nil)
    end

  end

end