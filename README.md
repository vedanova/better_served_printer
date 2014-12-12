# BetterServedPrinter

TODO: Write a gem description

## Configuration

    require 'betters_served_printer'

    # configuration
    BetterServedPrinter.configure api_key: 'API_KEY', account: 'ZYT'
    BetterServedPrinter.configure 'path/to/configuration.yml'

    printer = BetterServedPrinter::Printer.new
    printer.connect


## Sending a test message

    require 'pusher'
    Pusher.url = "http://KEY:SECRET@api.pusherapp.com/apps/APP_ID"
    message ="Hello World"

    Pusher['private_[ACCOUNT]_notifications'].trigger('message', { message: message })

## Installation

Add this line to your application's Gemfile:

    gem 'better_served_printer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install better_served_printer

## Usage

TODO: Write usage instructions here

## Build debian package



## Contributing

1. Fork it ( http://github.com/<my-github-username>/better_served_printer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
