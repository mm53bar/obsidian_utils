#!/usr/bin/env ruby

def read_markdown_directory(raw_directory)
  links = []
  rbfiles = File.join("**", "*.md")
  Dir.glob(rbfiles, base:raw_directory).each do |filename|
    links.push File.read(File.join(raw_directory,filename)).scan(/\[\[([^\]]*)\]\]/).flatten
  end
  links.flatten
end

def clean_empty_files(raw_directory, links_list)
  rbfiles = File.join("**", "*.md")
  Dir.glob(rbfiles, base:raw_directory).each do |filename|
    if File.zero?(File.join(raw_directory,filename))
      unless links_list.find {|link| link == filename.chomp('.md')}
        puts "Deleting #{filename}"
        File.delete(File.join(raw_directory,filename))
      end
    end
  end 
end

notes_path = "#{ENV['HOME']}/Notes/"

links_list = read_markdown_directory(notes_path)
clean_empty_files(notes_path, links_list)
