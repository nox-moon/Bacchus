require 'optparse'
require './helpers.rb'

# Parsing options
options = {}

optparse = OptionParser.new do |opts|

	opts.banner = "Usage: bacchus.rb [options] ..."

    options[:update] = false
    opts.on( '-u', '--update', 'Update presets' ) { |input| options[:update] = input }

    options[:launch] = false
    opts.on( '-l', '--launch SOFTWARE', 'Launch installed software' ) { |input| options[:launch] = input }

    options[:install] = false
    opts.on( '-i', '--install SOFTWARE', 'Install software' ) { |input| options[:install] = input }

    options[:delete] = false
    opts.on( '-d', '--delete SOFTWARE', 'Delete software' ) { |input| options[:delete] = input }

	# Help
    opts.on( '-h', '--help', 'Display this screen' ) do
    	puts opts
    	exit
   end

end

optparse.parse!


# Call functions
if options[:update] != false
	puts "update"

    # git pull the presets repo
end

if options[:launch] != false
	puts "launch"

    # Locate the script

    # If not found print error
end

if options[:install] != false
	puts "install"

    # parse
    hash = parse(options[:install])

    # build the prefix
    build_prefix(hash)

    # winetricks
    if hash['winetricks'] != ""
        winetricks(hash)
    end

    # install
    path = install(hash)

    # build the launcher script
    build_launcher(hash, path)
end

if options[:delete] != false
	puts "delete"

    puts "Are you sure you want to delete " + options[:delete] + "? [Y/N]"

    # delete the prefix
end