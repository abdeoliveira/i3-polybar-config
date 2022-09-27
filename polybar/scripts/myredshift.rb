#!/bin/ruby
#
#==========================================
begin_night = 1730
end_night = 730
night_temp = 3500
day_temp = 6000
transition_window = 130 # time window for a smooth screen temperature transition. 100 = 1h, 230 = 2h30min, etc.
#==========================================
#
#
#====LIMITATIONS==============
if end_night < 400 then puts 'ERROR: end_night must be >= 4h' ; abort  end
if end_night > 900 then puts 'ERROR: end_night must be =< 9h' ; abort end
if begin_night > 2100 then puts 'ERROR: begin_night must be =< 21h' ; abort end
if begin_night < 1600 then puts 'ERROR: begin_night must be >= 16h' ; abort end
if transition_window > 330 then puts 'ERROR: transition time window must be < 3h30min' ; abort end
#=============================
h = Time.now.hour
m = Time.now.min
time_now = h * 100 + m
#============= SMOOTH COLOR TEMPERATURE TRANSITION===================
#USED FUNCTION: y = alpha * x + beta
delta_temp = day_temp - night_temp
alpha = -delta_temp.to_f/transition_window
beta = night_temp - alpha * begin_night
begin_dark_transition = begin_night - transition_window
begin_light_transition = end_night - transition_window

temp = night_temp
if time_now >= end_night and time_now < begin_dark_transition then temp = day_temp end

if time_now >= begin_dark_transition and time_now < begin_night
  temp = (alpha * time_now + beta).to_i
end

alpha = -alpha
beta = day_temp - alpha * end_night

if time_now >= begin_light_transition and time_now < end_night
  temp = (alpha*time_now + beta).to_i
end

`DISPLAY=:0 sct #{temp}`
File.write('/home/oliveira/.screen_temp',"#{temp} K",mode:'w')
#========================================
temp = (temp.to_f/1000).round(1)
puts "#{temp} K"
