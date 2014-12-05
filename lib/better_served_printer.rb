require 'yaml'
require 'logger'
require "better_served_printer/version"
require "better_served_printer/configuration"
require 'better_served_printer/connection'
require 'better_served_printer/printer'

module BetterServedPrinter
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(opts = {})
    if opts.is_a?(Hash)
    opts.each {|k,v| configuration.send(:set, k.to_sym, v) if Configuration::VALID_CONFIG_KEYS.include? k.to_sym}
    else
      configure_with(opts)
    end
  end

  # Configure through yaml file
  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML::load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      logger.error("YAML configuration file couldn't be found. Using defaults."); return
    rescue Psych::SyntaxError
      logger.error("YAML configuration file contains invalid syntax. Using defaults."); return
    end

    configure(config)
  end

  def self.logger
    @logger ||= begin
      log = Logger.new("/tmp/better_served_printer.log", 10, 1024000)
      log.level = Logger::DEBUG
      log
    end
  end

  def self.logger=(logger)
    @logger = logger
  end

end
