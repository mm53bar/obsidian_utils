#!/usr/bin/env ruby

def read_markdown_directory(raw_directory)
  contents = {}
  rbfiles = File.join("**", "*.md")
  Dir.chdir(raw_directory) do
    Dir.glob(rbfiles).sort_by{ |f| File.mtime(f) }.reverse.each do |filename|
      unless filename == 'TODO.md'
        contents[filename.chomp('.md')] = File.read(filename, :encoding => 'utf-8')
      end
    end
  end
  contents
end

def extract_todo_lines(contents)
  todo_lines = {}
  contents.each do |filename, content|
    todo_text = ''
    content.scan(/[\*\-+]\s\[\s\]\s(.*)/).flatten.each do |match|
      todo_text += "- #{match} [[#{filename}]]\n"
    end
    todo_lines[filename] = todo_text unless todo_text.empty?
  end
  return todo_lines
end

def write_simple_todo_file(filepath, todo_lines)
  todo_notes = todo_lines.map{ |k,v| v }.join
  File.write(filepath, "# TODO\n\n#{todo_notes}")
end

def write_todo_file(filepath, todo_lines)
  File.open(filepath, 'w') do |file|
    file.write "# TODO\n\n"
    todo_lines.each do |filename, lines|
      file.write "## #{filename}\n\n#{lines}\n"
    end
  end 
end 

notes_path = "#{ENV['HOME']}/Notes/"
todo_filepath = notes_path + 'TODO.md'

notes = read_markdown_directory(notes_path)
todo_lines = extract_todo_lines(notes)

write_simple_todo_file(todo_filepath, todo_lines)



