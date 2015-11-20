# kitchenboard
A Dashing.io dashboard meant to run on a Raspberry Pi 2 with 7" touchscreen

### Installation
You need to follow the installation instructions on http://shopify.github.com/dashing as well as a couple others to get dashing to work on a RPi 2.
Have a look at
 - Install node.js on RPi: http://node-arm.herokuapp.com/
 - Cooking up an Office Dashboard Pi: https://gocardless.com/blog/raspberry-pi-metric-dashboards/
 - Install tellstick software: http://elinux.org/R-Pi_Tellstick_core
 - Install tellprox: https://github.com/p3tecracknell/tellprox

### Configuration
You need to add a folder called _secrets_ in the root of the project and place a file called **_keys.rb_** in it with content like this:

```ruby
class KitchenKeys
  TELLPROX_API_KEY = '<your private tellprox api key goes here>'
  FORECAST_API_KEY = '<your private forecast.io api key goes here>'
end
```
