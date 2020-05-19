# Obsidian Utils

Various scripts and utilities for Obsidian.md

## Usage

### journal.rb

To run:

```
ruby journal.rb
```

Journal.rb simply creates a file following the `YYYY-MM-DD.md` naming convention that Obsidian uses for daily notes. This file will be created in your notes directory following a template that's listed in the script. Currently, it pulls some weather data from Environment Canada, adds some boilerplate tasks for the day, and embeds links to the previous five days of daily notes.

Note that it will not overwrite the daily note for today if it already exists. It will only ever append to it.

### todo.rb

To run:

```
ruby todo.rb
```

Todo.rb will loop through all of the markdown files in your notes directory (including subdirectories) to find any lines that follow the syntax for empty checklists. Then it writes them all (as a copy, not an embed) to a file called `TODO.md` in your notes directory.

This script will work for the `*`, `-`, and `+` bullet syntaxes in Markdown.

```
* [ ] This is a todo
- [ ] This is a todo
+ [ ] This is a todo
```

**NOTE** - this script overwrites the `TODO.md` file each time it is run. If you manually write any notes to `TODO.md` and then run this script, those notes will be lost.

### clean.rb

To run:

```
ruby clean.rb
```

Clean.rb will loop through all ofthe markdown files in your notes directory (including subdirectories) to find any files that are both 1) empty (filesize = zero), and 2) unlinked in any other note. If it finds notes that fit those criteria, it deletes them from your filesystem.

**NOTE** - this script is intentionally destructive! It is highly recommended that you have your notes under version control or backed up somehow before runing this script. Cleaned files are not moved to the trash - they are immediately deleted!

## How to run Ruby scripts

You'll need to have ruby installed on your machine. Type `ruby -v` to see if it's already set up. If you need to install it, check out https://www.ruby-lang.org/en/documentation/installation/

Once you have ruby installed, you should be able to execute any of the scripts by going to the directory where the script is stored and typing `ruby scriptname.rb`, replacing `scriptname.rb` with the actual name of the script i.e. `journal.rb` or `todo.rb`.

## Notes

- Back up your vault before executing any of these scripts! They might be destructive and could wipe out all of your notes.
- I keep all of my notes in one folder that's in a `Notes` folder in my home folder. I try to keep a variable for the `notes_path` in each of the scripts that you can edit for your local setup.

## Disclaimer

Note that I've built all of these for my own use. Weather is for my local city, pathing is for my machine. You may need to fork the repo and update the scripts for your own use. Buyer beware! I try to make the scripts as safe as I can, but I won't take responsibility if your notes get deleted or overwritten by these scripts.
