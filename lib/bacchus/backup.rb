def backup()

	time = Time.new
	date = time.year.to_s + "-" + time.month.to_s + "-" + time.day.to_s

	cmd = "tar -C " + ENV['HOME'] + "/.bacchus -cvf backup-" + date + ".tar prefixes launchers"
	system cmd

end