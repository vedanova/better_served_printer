module BetterServedPrinter
  class Configuration
    VALID_CONFIG_KEYS = [:log_level, :api_key, :api_secret, :user_id, :account]

    attr_accessor *VALID_CONFIG_KEYS

    def initialize
      @log_level = Logger::DEBUG
    end

    def set(key, value)
      send("#{key}=", value)
    end

  end
end