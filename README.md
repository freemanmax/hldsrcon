# Hldsrcon

Hldsrcon gem is Counter-Strike 1.6 Server remote console, the gem use UDP Socket to send and
receive data or to execute Counter-Strike 1.6 Server command and receive respons from Server.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hldsrcon'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install hldsrcon
```

## Usage

To use this game you have first to installet the gem.
Use this example, create new ruby file rcon.rb and put this in it:

```ruby
require 'hldsrcon'

@conn = RconHlds.new("192.168.0.1", 27015, 29015)
@conn.rcon_pass('ctx')
rcon = @conn.rcon_command('sv_restart 1')
puts rcon
```

Note 'ctx' is the Counter-Strike 1.6 Server rcon_password.
After this run the rcon.rb file in terminal, make sure that your terminal directory is where the file is located
and after this run ruby rcon.rb. If everything go well you should get respons from server like this:
```
L 04/24/2016 - 10:04:21: Server cvar "sv_restart" = "1" 
```
If you get:
```
Bad Rcon 
```
Your Counter-Strike 1.6 Server rcon_password is wrong.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

