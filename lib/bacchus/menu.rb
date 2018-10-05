require 'ncurses'
require 'bacchus/helpers.rb'

def menu()
    scr = Ncurses.initscr
    Ncurses.cbreak
    Ncurses.noecho

    Ncurses.keypad(scr, true)

    # Initial menu
    choices = [ "Install",
                "Launch",
                "Delete",
                "Update",
                "Backup",
                "Exit" ]

    level = "top"

    menu = build_menu(choices)
    menu.post_menu
    Ncurses.refresh

    ch = Ncurses.getch
    while ch != Ncurses::KEY_EXIT
        if ch == Ncurses::KEY_UP
            menu.menu_driver(Ncurses::Menu::REQ_UP_ITEM)
        elsif ch == Ncurses::KEY_DOWN
            menu.menu_driver(Ncurses::Menu::REQ_DOWN_ITEM)
        elsif 10

        	# Top level menu
            if menu.current_item.item_name == "Install"
                system "clear"
                level = "install"
                # TODO Modularize this
                dir = ENV['HOME'] + "/.bacchus/presets/*"
                files = Dir[dir]
                choices = []
                files.each do |file|
                    if !File.directory? file
                        file_name = File.basename(file, ".*")
                        if file_name != "README"
                        	choices.push(file_name)
                        end
                    end
                end
                choices.push("Exit")

                menu = build_menu(choices)
                # TODO: set_format should account for terminal size to determine how many rows to display at once
                #menu.set_format(25,1)
                menu.post_menu

        	elsif menu.current_item.item_name == "Launch"
        		system "clear"
        		level = "launch"
        		# TODO Modularize this
        		dir = ENV['HOME'] + "/.bacchus/prefixes/*"
			    files = Dir[dir]
			    choices = []
			    files.each do |file|
			        if File.directory? file
			            file_name = File.basename file
			            choices.push(file_name)
			        end
			    end
			    choices.push("Exit")

	            menu = build_menu(choices)
    			menu.post_menu

    		elsif menu.current_item.item_name == "Exit"
    			exit

            # Install menu
            elsif level == "install"
                # TODO turn this into a function
                    # Copied from bacchus.rb
                recipe = parse(menu.current_item.item_name)
                build_prefix(recipe)
                if recipe['winetricks'] != ""
                    winetricks(recipe)
                end
                install(recipe)
                build_launcher(recipe)

    		# Launch menu
    		elsif level == "launch"
    			# Get the name of the application to launch
    			app_name = menu.current_item.item_name
    			cmd = "bash " + ENV['HOME'] + "/.bacchus/launchers/" + app_name + ".sh &> /dev/null"
    			system cmd
    			# exit
        	end
        end
        ch = Ncurses.getch
    end

    ensure
	    Ncurses.echo
	    Ncurses.nocbreak
	    Ncurses.nl
	    Ncurses.endwin
end

def build_menu(choices)
    menu_items = []

    choices.each_with_index do | choice, index |
      menu_items << Ncurses::Menu::ITEM.new(choice, "")
    end
    return Ncurses::Menu::MENU.new(menu_items)
end