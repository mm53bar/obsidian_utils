#!/usr/bin/env ruby
require 'date'

filepath = "#{ENV['HOME']}/Notes/"
today = Date.today
filename = today.strftime('%Y-%m-%d.md')
last_year = today.prev_year.strftime('%Y-%m-%d')
this_week = today.strftime('%G-W%V')

weather_raw = `curl -s https://weather.gc.ca/rss/city/ab-50_e.xml`
today_weather_raw = weather_raw.split('<entry>').slice(3..4).join
today_weather_list = today_weather_raw.scan(/.*<title>(.*)<\/title>/).flatten

journal_template = <<~JOURNAL
  # #{today.strftime('%A, %b %d, %Y')}
  [[#{last_year}]] | [[#{this_week}]]

  ## Weather
  #{today_weather_list[0]}
  #{today_weather_list[1]}

  ## Daily Notes

  - [ ] 🗓 Check calendar for scheduled events
  - 

JOURNAL

File.open("#{filepath}#{filename}", 'a') { |f| f.write "#{journal_template}" }

puts "Wrote template to #{filepath}#{filename}"
