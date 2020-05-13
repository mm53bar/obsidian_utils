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
  todo_lines = {}
  na_lines = {}
  contents.each do |filename, content|
    todo_text = ''
    na_text = ''
    content.scan(/[\*\-+]\s\[\s\]\s.*/).flatten.each do |match|
      todo_text += "#{match} [[#{filename}]]\n"
    end
    content.scan(/[\*\-+]\s\[\s\]\s.*@na.*/).flatten.each do |match|
      na_text += "#{match} [[#{filename}]]\n"
    end
    todo_lines[filename] = todo_text unless todo_text.empty?
    na_lines[filename] = na_text unless na_text.empty?
  end
  return todo_lines, na_lines
end

notes_path = "#{ENV['HOME']}/Notes/"
todo_filepath = notes_path + 'TODO.md'

notes = read_markdown_directory(notes_path)
todo_lines, na_lines = extract_todo_lines(notes)
#File.write(todo_filepath, "# TODO\n\n#{todo_notes}")
File.open(todo_filepath, 'w') do |file|
  file.write "# TODO\n\n"
  unless na_lines.empty?
    file.write "## Next Actions\n\n"
    na_lines.each do |filename, lines|
      file.write "#{lines}\n"
    end
  end
  todo_lines.each do |filename, lines|
    file.write "## #{filename}\n\n#{lines}\n"
  end
end