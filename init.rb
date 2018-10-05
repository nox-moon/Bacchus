def init_dots()
	# Create dotfiles
	dir = ENV['HOME'] + '/.bacchus'
	if !File.exist?(dir)
		cmd = 'mkdir ' + dir
		system cmd

		cmd = 'mkdir ' + dir + '/prefixes'
		system cmd

		cmd = 'mkdir ' + dir + '/presets'
		system cmd

		cmd = 'mkdir ' + dir + '/launchers'
		system cmd
	end
end