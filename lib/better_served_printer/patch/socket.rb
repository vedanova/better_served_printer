# patch connect to allow rescuing of connection errors
module PusherClient
  class Socket
    def connect(async = false)
      if @encrypted
        url = "wss://#{@ws_host}:#{@wss_port}#{@path}"
      else
        url = "ws://#{@ws_host}:#{@ws_port}#{@path}"
      end
      PusherClient.logger.debug("Pusher : connecting : #{url}")
      @connection_thread = Thread.new {
        begin
          options     = {:ssl => @encrypted, :cert_file => @cert_file, :ssl_verify => @ssl_verify}
          @connection = PusherWebSocket.new(url, options)
          PusherClient.logger.debug "Pusher : Websocket connected"

          loop do
            msg    = @connection.receive[0]
            next if msg.nil?
            params = parser(msg)
            next if params['socket_id'] && params['socket_id'] == self.socket_id

            send_local_event params['event'], params['data'], params['channel']
          end
        rescue # SocketError => se
          @connected = false
          msg = "Pusher : Cannot connect to the Internet"
          PusherClient.logger.warn msg
        end
      }
      @connection_thread.run
      @connection_thread.join unless async
      self
    end
  end
end