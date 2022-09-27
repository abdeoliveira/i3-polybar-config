#!/usr/bin/ruby

def toggle(mode,service)
  font = '-fa Monospace -fs 12'
  if mode == '@dark' 
    background = '#424242'
    foreground = '#cfd8dc'
  end
  if mode == '@light'
    background = '#eceff1'
    foreground = '#212121'
  end
  if service == 'battery'
    geometry = '-geometry 20x2-10+30'
    `xterm -bg '#{background}' -fg '#{foreground}' #{font} #{geometry} -e 'echo "Battery Level: $(cat /sys/class/power_supply/BAT0/capacity)%" && sleep 5'`
  end
  if service == 'wifi'
    geometry = '-geometry 40x3-10+30'
    `xterm -bg '#{background}' -fg '#{foreground}' #{font} #{geometry} -e 'iwconfig wlan0 | grep ESSID && sleep 5'`
  end
  if service == 'calendar'
    geometry = '-geometry 70x33-600+30'
    `xterm -bg '#{background}' -fg '#{foreground}' #{font} #{geometry}  -hold -e 'cal -Y' `
  end
  if service == 'cpu'
    geometry = '-geometry 110x30'
    `xterm -bg '#{background}' -fg '#{foreground}' #{font} #{geometry} -e top`
  end
end

toggle(ARGV[0],ARGV[1])
