#!/usr/bin/ruby
data = `top -b -n 1 | grep Cpu`
cpu_idle = data.split(',')[3].split.first
cpu_use = (100 - cpu_idle.to_f).round
puts "#{cpu_use}%"
