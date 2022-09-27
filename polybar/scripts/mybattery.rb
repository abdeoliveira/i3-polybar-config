#!/usr/bin/ruby
critical_level = 10
#========================
level = `cat /sys/class/power_supply/BAT0/capacity`.strip.to_i
status = `cat /sys/class/power_supply/BAT0/status`.strip
battery_alert_icon = '/home/oliveira/.icons/battery_low.png'
#==========ALERT=========
if level <= critical_level and status == 'Discharging' then `notify-send \
  -h string:fgcolor:#ff4444 -h string:bgcolor:#ffffff \
  'Critical Level: #{level}%' \
  'Plug into a power source immediately!' -i #{battery_alert_icon}` end
#========================
icon = ""
if level > 20 then icon = "" end
if level > 40 then icon = "" end
if level > 60 then icon = "" end
if level > 80 then icon = "" end
if status == 'Charging' then icon = icon+"" end
#=========================
puts icon


