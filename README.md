# Domoticz [![Circle CI](https://circleci.com/gh/jankeesvw/domoticz.svg?style=svg)](https://circleci.com/gh/jankeesvw/domoticz)

Manage your Domoticz server from Ruby

This gem is work in progress!

## Connect to your server

```
Domoticz.configure do |config|
  config.server = "http://127.0.0.1/"
  config.username = "user"
  config.password = "password"
end
```

## Devices

### List all devices

```ruby
devices = Domoticz::Switch.all
# => [#<Domoticz::Switch:0x007fc51e203420 @name="Energy", @dimmer=nil, @idx="6", @type="P1 Smart Meter", @subtype="Energy">, #<Domoticz::Switch:0x007fc51e203308 @name="Gas", @dimmer=nil, @idx="7", @type="P1 Smart Meter", @subtype="Gas">, #<Domoticz::Switch:0x007fc51e2031c8 @name="Test switch", @dimmer=nil, @idx="8", @type="Lighting 1", @subtype="X10">]
```

### Interact with a switch
```ruby
switch = Domoticz::Devices.all.first
switch.on! # turn it on
switch.off! # turn it off
switch.toggle! # toggle switch
```

# Contributing

1. Fork it ( https://github.com/jankeesvw/domoticz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
