require 'pathname'

def get_notes_path_from_cli_args()
  if ARGV.length == 1
    notes_path = Pathname.new(ARGV[0])
  else
    notes_path = Pathname.new("#{ENV['HOME']}/Notes/")
  end
  
  if not notes_path.directory?
    Kernel.abort("Directory [#{notes_path}] does not exist.
Please specify your notes directory as a command line argument.
   ex: ruby todo.md ~/john/my_notes")
  else
    puts "notes path: #{notes_path}".inspect
  end

  return notes_path
end
