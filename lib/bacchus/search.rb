def search(term)
	dir = ENV['HOME'] + "/.bacchus/presets/*.json"

	files = Dir[dir]

	files.each do |file|
		if !File.directory? file
			extn = File.extname file
			file_name = File.basename file, extn
			if file_name.include? term
				puts file_name
			end
		end
	end

end