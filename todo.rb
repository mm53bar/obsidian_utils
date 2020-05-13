#!/usr/bin/env ruby

def read_markdown_directory(raw_directory)
  contents = {}
  rbfiles = File.join("**", "*.md")
  Dir.glob(rbfiles, base:raw_directory).each do |filename|
    unless filename == 'TODO.md'
      contents[filename.chomp('.md')] = File.read(File.join(raw_directory,filename))
    end
  end
  contents
end

def extract_todo_lines(contents)
  todo_text = ''
  contents.each do |filename, content|
    content.scan(/[\*\-+]\s\[\s\]\s.*/).flatten.each do |match|
      todo_text += "#{match} [[#{filename}]]\n"
    end
  end
  todo_text = 'Nothing to do!' if todo_text.empty?
  return todo_text
end

notes_path = "#{ENV['HOME']}/Notes/"
todo_filepath = notes_path + 'TODO.md'

notes = read_markdown_directory(notes_path)
todo_notes = extract_todo_lines(notes)
File.write(todo_filepath, "# TODO\n\n#{todo_notes}")
