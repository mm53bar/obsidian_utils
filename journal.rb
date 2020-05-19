#!/usr/bin/env ruby
require 'date'

filepath = "#{ENV['HOME']}/Notes/"
today = Date.today
filename = today.strftime('%Y-%m-%d.md')
last_year = today.prev_year.strftime('%Y-%m-%d')
this_week = today.strftime('%G-W%V')
this_week_monday = today - (today.cwday-1)
week_filename = this_week + '.md'

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

puts "Wrote daily template to #{filepath}#{filename}"

weekly_template = <<~WEEKLY
  # #{this_week}

  ## Big Three
    1. 
    2. 
    3. 

  ## Daily stuff
    - Monday, [[#{this_week_monday.strftime('%Y-%m-%d')}]]
    - Tuesday, [[#{this_week_monday.next_day.strftime('%Y-%m-%d')}]]
    - Wednesday, [[#{this_week_monday.next_day(2).strftime('%Y-%m-%d')}]]
    - Thursday, [[#{this_week_monday.next_day(3).strftime('%Y-%m-%d')}]]
    - Friday, [[#{this_week_monday.next_day(4).strftime('%Y-%m-%d')}]]
    - Saturday, [[#{this_week_monday.next_day(5).strftime('%Y-%m-%d')}]]
    - Sunday, [[#{this_week_monday.next_day(6).strftime('%Y-%m-%d')}]]
    
  ## Last week [[#{(today-7).strftime('%G-W%V')}]]
    - Tasks:
        - [ ] Add meetings from last week to contacts and events
        - [ ] Make sure all [[TODO]] items from last week were either closed or moved
        - [ ] Make sure there are no recurring items that somehow got marked as [[DONE]]
    - Biggest wins:
        - 
    - How far did you get on last week's big 3?
      1. 
      2. 
      3. 
    - What worked? What didn't?
      - 
    - What will you keep, improve, start, or stop based on the above?
      - 
WEEKLY

unless File.exist?("#{filepath}#{week_filename}") 
  File.open("#{filepath}#{week_filename}", 'w') { |f| f.write "#{weekly_template}" }
  puts "Wrote weekly template to #{filepath}#{week_filename}"
end