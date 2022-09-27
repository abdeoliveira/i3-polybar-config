#!/usr/bin/ruby
delta_time = 1.0 #ARGV[1].to_f #seconds
iface = ARGV[0] 
megabyte   = 1024 * 1024
kilobyte = 1024

def netdata(iface)
  data = `cat /proc/net/dev`
  dataline = data.split("\n")
  dataline.each do |l|
    device = l.split(" ")
    if device[0].include? iface
      @dl = device[1].to_f
      @ul = device[9].to_f
    else
      @dl = 0
      @ul = 0
    end
  end
  return [@dl,@ul]
end

a = netdata(iface)
sleep delta_time
b = netdata(iface)

delta_dl = b[0] - a[0]
delta_ul = b[1] - a[1]

rx = delta_dl/megabyte/delta_time
tx = delta_ul/megabyte/delta_time
speed = (rx+tx).round(1).to_s+" Mb/s"

if rx+tx <= 0.1 
    puts ""
else
    if rx/tx > 4 
        puts ""+speed
    elsif tx/rx > 4
        puts ""+speed
    else
        puts ""+speed 
    end
end

#puts "#{rx} #{r_units} #{tx} #{t_units}"


