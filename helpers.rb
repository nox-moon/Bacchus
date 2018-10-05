require 'json'
require 'pathname'
require 'shellwords'

def parse(file_name)
	dir = ENV['HOME'] + '/.bacchus/presets/' + file_name + '.json'
	if !File.exist?(dir)
		puts "Error! No preset for that software"
		exit
	end
	file = File.read(dir)
	data_hash = JSON.parse(file)
end

def build_prefix(hash)
	prefix_name = hash['name']
	arch = hash['arch']
	win = hash['win']

	# build the prefix
	output = 'WINEARCH=' + arch + ' WINEPREFIX=~/.bacchus/prefixes/' + prefix_name + ' winecfg &> /dev/null'
	system output, :out => File::NULL
end

def winetricks(hash)
	prefix_name = hash['name']
	cmd = 'WINEPREFIX='  + ENV['HOME'] + '/.bacchus/prefixes/' + prefix_name + ' winetricks ' + hash['winetricks']
	system cmd
end

def install(hash)
	type = hash['type']
	software_name = hash['name']
	locale = hash['locale']

	# Clear the screen in case there is a bunch of winetricks text
	# Makes it easy for the user to see they actually need to do something
	# TODO Possibly break this out into a separate function,
	# Not sure how often clearing the screen will be helpful
	cmd = "clear"
	system cmd

	if type == "exe"
		puts "Please specify the path to the " + software_name + " exe file: "
		path = gets.chomp
		puts path
	elsif type == "dir"
		puts "Please specify the path to the " + software_name + " directory: "
		path = gets.chomp
		if path[-1] == "/"
			puts "Not a directory"
		end
		install_dir(path, software_name)
	else
		puts "Please specify the path to the " + software_name + " installer exe file: "
		path = gets.chomp
		launch_setup(path, software_name, locale)
	end
end

def install_dir(path, prefix_name = nil)
	if !prefix_name
		prefix_name = '~/.wine' # Assume default wine directory
	end

	# TODO Be smart and don't just dump the contents if the user adds a slash to the end
	output = 'cp -r ' + path + ' ~/.bacchus/prefixes/' + prefix_name + '/drive_c/Program\ Files'
	system output
end

def launch_setup(path, prefix_name = nil, locale = nil)
	if !prefix_name
		prefix_name = '~/.wine' # Assume default wine directory
	end

	if locale == ""
		output = 'WINEPREFIX=' + ENV['HOME'] + '/.bacchus/prefixes/' + prefix_name + ' wine ' + path
	else
		output = 'WINEPREFIX=' + ENV['HOME'] + '/.bacchus/prefixes/' + prefix_name+  ' LANG="' + locale + '" wine ' + path
	end
	system output
end

def build_launcher(hash)
	exe = hash['exe']
	prefix_name = hash['name']
	
	# Get the full file path
	cmd = "find " + ENV['HOME'] + '/.bacchus/prefixes/' + prefix_name + " drive_c -name " + exe + ".exe"
	full_path = Shellwords.escape `#{cmd}`

	# Get the directory path
	cmd = "dirname " + full_path
	dirname = Shellwords.escape `#{cmd}`
	3.times do dirname.chop! end # TODO: This makes me super uncomfortable

	locale = hash['locale']

	if !prefix_name
		prefix_name = '~/.wine'
	end

	name = ENV['HOME'] + '/.bacchus/launchers/' + prefix_name + '.sh'

	# TODO Check to make sure file doesn't already exist
	file = File.new(name, 'w')
	open(name, 'a') { |f|
	 	f.puts '#!/bin/bash'
	 	f.puts 'cd ' + dirname.strip
	 	if locale == ""
	 		f.puts 'WINEPREFIX=' + ENV['HOME'] + '/.bacchus/prefixes/' + prefix_name + ' wine ' + exe + ".exe"
	 	else
	 		f.puts 'WINEPREFIX=' + ENV['HOME'] + '/.bacchus/prefixes/' + prefix_name + ' LANG="' + locale + '" wine ' + exe + ".exe"
	 	end
	}

	# Make the script executable
	exec = "chmod 755 " + name
	system exec
end