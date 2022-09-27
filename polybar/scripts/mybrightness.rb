#!/usr/bin/ruby
current = `cat /sys/class/backlight/intel_backlight/brightness`
max     = `cat /sys/class/backlight/intel_backlight/max_brightness`
percent = (current.to_f/max.to_f) * 100
if percent < 10 then icon = "" end
if percent >= 10 and percent < 20 then icon = "" end
if percent >= 20 and percent < 40 then icon = "" end
if percent >= 40 and percent < 60 then icon = "" end
if percent >= 60 and percent < 80 then icon = "" end
if percent >= 80 and percent < 90 then icon = "" end
if percent >= 90 then icon = "" end
puts "#{icon} "


