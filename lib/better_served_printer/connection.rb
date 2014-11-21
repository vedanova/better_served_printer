require 'pusher-client'
require_relative "patch/socket.rb"
module BetterServedPrinter
  class Connection

    def initialize(printer, config)
      @connection_alive = false
      @printer = printer
      @config = config
      options = { secure: true }
      @socket = PusherClient::Socket.new(@config.api_key, options)
      PusherClient.logger.level = Logger::INFO
      @logger = BetterServedPrinter.logger
    end

    def subscribe
      @logger.info "Subscribing"
      channel = @socket.subscribe(private_channel, @config.account)
      log_connection(@socket)
      channel.bind('message') do |data|
        @logger.debug "Incoming Message"
        msg = JSON.parse(data)
        @printer.print(msg)
      end
      connect
    end

    def connect
      check_connection_status unless @connection_status_thread
      @socket.connect(true)
      if @socket.connected == false
        msg = "Not connected, reconnecting..."
        @logger.warn msg
      end
    end

    def disconnect
      @socket.disconnect
    end

    def log_connection(socket)
      socket.bind('pusher:connection_established') do |data|
        @logger.info "Connection established"
        @connection_alive = true
      end

      socket[private_channel].bind('pusher_internal:subscription_succeeded') do |event|
        @logger.info "Successful connected to #{private_channel}"
      end

      socket[private_channel].bind('pusher_internal:subscription_error') do |event|
        @logger.error "Can't connect to #{private_channel}"
      end

      socket.bind('pusher:connection_disconnected') do |data|
        @logger.debug "Connection disconnected"
      end

      socket.bind('pusher:error') do |data|
        @logger.fatal("Pusher : error : #{data.inspect}")
      end

      socket.bind('pusher:pong') do
        @connection_alive = true
      end

    end

    def check_connection_status
      @connection_status_thread = Thread.new do
        loop do
          if @connection_alive
            @socket.send_event('pusher:ping', nil)
            @connection_alive = false
          else
            @logger.warn "Disconnected, reconnecting"
            disconnect
            connect
          end
          sleep(5)
        end
      end
      @connection_status_thread.run
    end

    def stop_monitoring!
      Thread.kill(@connection_status_thread)
    end

    private

    def private_channel
      "private_#{@config.account}_notifications"
    end

  end
end

