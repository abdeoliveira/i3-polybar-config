#!/bin/ruby
file_restart = '/home/oliveira/.dunst_restart_service'

def state
    h = `dunstctl count history`.to_i
    d = `dunstctl count displayed`.to_i
    w = `dunstctl count waiting`.to_i
    is_paused = `dunstctl is-paused`.strip
    if h+d+w > 0 
       icon = '' 
    else
       icon = ''
    end
    if is_paused == 'true' then icon = '' end
    return icon
end

if ARGV[0] == 'clear'
  `systemctl --user restart dunst.service`
  if File.exist? (file_restart) then File.delete(file_restart) end
  puts state
elsif ARGV[0] == 'show' 
   h = `dunstctl count history`.to_i
   h.times do
      `dunstctl history-pop`
   end
   File.write(file_restart,"",mode:'w')
   puts state
elsif  ARGV[0] == 'toggle'
  `dunstctl set-paused toggle`
   puts state
else
   if File.exist? (file_restart) 
      d = `dunstctl count displayed`.to_i
      if d==0 
        `systemctl --user restart dunst.service` 
         File.delete(file_restart)
       end
   end
   puts state
end




