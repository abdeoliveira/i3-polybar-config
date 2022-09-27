#!/bin/ruby
#=========================================
status_file = '/home/oliveira/.auto-dark-status'
#==========================================
begin_night = 1730
end_night = 630
dark_theme = 'Arc-Dark'
light_theme = 'Arc'
#==========================================
def togglegtk(from_theme,to_theme)
   xsettingsd_file = '/home/oliveira/.config/xsettingsd/xsettingsd.conf'
   settings = File.read(xsettingsd_file).strip
   settings = settings.sub(from_theme,to_theme)
   File.write(xsettingsd_file,settings,mode:'w')
   `killall -HUP xsettingsd`
end
#==========================================
def togglepoly(mode)
   polybar_config_file = '/home/oliveira/.config/polybar/config.ini'
   config = File.read(polybar_config_file)
   poly_dark = config.split('#DARKTHEME')[1].split('#LIGHTTHEME')[0].strip
   poly_light = config.split('#LIGHTTHEME')[1].split('#ENDLIGHT')[0].strip
   uncomment_poly_dark = poly_dark.gsub('#background','background').sub('#foreground','foreground')
   uncomment_poly_light = poly_light.gsub('#background','background').sub('#foreground','foreground')
   comment_poly_light = poly_light.gsub('background','#background').sub('foreground','#foreground')
   comment_poly_dark = poly_dark.gsub('background','#background').sub('foreground','#foreground')
   if mode == 'go_dark'
     config.sub!(poly_light,comment_poly_light)
     config.sub!(poly_dark,uncomment_poly_dark)
     config.gsub!('@light','@dark')
   end
   if mode == 'go_light'
     config.sub!(poly_light,uncomment_poly_light)
     config.sub!(poly_dark,comment_poly_dark)
     config.gsub!('@dark','@light')
   end
File.write(polybar_config_file,config,mode:'w')
`pkill -USR1 polybar`
end
#==============================================
def toggleterm(mode)
  file = '/home/oliveira/.config/xfce4/terminal/terminalrc'
  config = File.read(file)
  if mode == 'go_light'
    config.sub!('ColorUseTheme=TRUE','ColorUseTheme=FALSE')
  end
  if mode == 'go_dark'
    config.sub!('ColorUseTheme=FALSE','ColorUseTheme=TRUE')
  end
 File.write(file,config,mode:'w') 
end
def togglerofi(from_theme,to_theme)
  file = '/home/oliveira/.config/rofi/config.rasi'
  config=File.read(file)
  config.sub!(from_theme,to_theme)
  File.write(file,config,mode:'w')
end
#=========================================
h = Time.now.hour
m = Time.now.min
time_now = h * 100 + m
it_is_night = true
if time_now >= end_night and time_now < begin_night then it_is_night = false end
#========================================
if File.exist? (status_file) then status = File.read(status_file).strip end
#========================================
go_dark = false
go_light = false
if status.nil? and it_is_night then  go_dark = true  end
if status.nil? and not it_is_night then go_light = true end
if status == 'light' and it_is_night then go_dark = true end
if status == 'dark' and not it_is_night then go_light = true end
#========================================

#===TOGGLE LIGHT/DARK THEME=====
if go_dark
  mode = 'go_dark'
  togglegtk(light_theme,dark_theme)
  togglerofi(light_theme,dark_theme)
  togglepoly(mode)
  toggleterm(mode)
  File.write(status_file,'dark',mode:'w')
end
if go_light
  mode = 'go_light'
  togglegtk(dark_theme,light_theme)
  togglerofi(dark_theme,light_theme)
  togglepoly(mode)
  toggleterm(mode)
  File.write(status_file,'light',mode:'w')
end
#================================
status = File.read(status_file).strip
if status == 'dark' then puts '' end
if status == 'light' then puts '' end



