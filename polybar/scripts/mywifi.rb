#!/usr/bin/ruby
txpower_data = `iwconfig #{ARGV[0]} | grep Quality`.strip
unless txpower_data.empty?
  power = txpower_data.split('Link Quality=')[1].split(' ')[0]
  a = power.split("/")[0]
  b = power.split("/")[1]
  signal = ((a.to_f/b.to_f) * 100).round

  ssid_data = `iwconfig wlan0 | grep ESSID`.strip
  ssid = ssid_data.split("ESSID:")[1].delete('"')
  
  icon = ""
  if signal > 30 then icon = "" end
  if signal > 50 then icon = "" end
  if signal > 70 then icon = "" end
  if signal > 90 then icon = "" end
else
  icon = ""
end
if ssid.nil?  
  puts icon 
else
  #puts ssid
  puts icon
end


