#!/usr/bin/env ruby
require 'date'

def read_markdown_directory(raw_directory)
  contents = {}
  recent_day_range = (Date.today.prev_day(7)..Date.today)
  recent_day_range.reverse_each{|date| contents[date.to_s] = []}
  rbfiles = File.join("**", "*.md")
  Dir.chdir(raw_directory) do
    Dir.glob(rbfiles).sort_by{ |f| File.mtime(f) }.reverse.each do |filename|
      if recent_day_range.cover?(File.mtime(filename).to_date) && !%w(RECENT.md TODO.md).include?(filename)
        contents[File.mtime(filename).strftime('%Y-%m-%d')] << filename.chomp('.md')
      end
    end
  end
  contents
end

def write_recent_file(filepath, recent_notes)
  File.open(filepath, 'w') do |file|
    file.write "# Recent Notes\n\n"
    recent_notes.each do |filename, lines|
      unless recent_notes[filename].empty?
        file.write "## #{filename}\n#{lines.map{|f| "- [[#{f}]]"}.join("\n")}\n\n"
      end
    end
  end 
end 

notes_path = "#{ENV['HOME']}/Notes/"
recent_filepath = notes_path + 'RECENT.md'

recent_notes = read_markdown_directory(notes_path)

write_recent_file(recent_filepath, recent_notes)



