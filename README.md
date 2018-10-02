# Bacchus
Managing Wine prefixes can be somewhat daunting for a newcomer and the existing GUI utilities, in my opinion, are either needlessly confusing or simply nonfunctional. Bacchus is my attempt to create a simple Wine management utility that actually works.

## Current Features
* Installing software from a directory

* Installing software from a setup.exe file

* Output an executable .sh for ease of launching

* Creating a backup of your prefixes and launchers

* Search for preset names directly from Bacchus

* Application management. Bacchus will manage all of your installed applications for you so you don't need to remember which application you installed in which prefix and how to launch it.

## Planned Features
* Installing software from a self-contained exe file. I've struggled to find an example of this, but I'm sure they exist. If someone could point me to a free example I would appreciate it.

* Deleting prefixes and launchers from Bacchus.

* A Ruby gem for those who want it

## Far in the Future Features
* An ncurses UI

* Swapping between Wine versions

* Bundling a specific Wine version with a prefix for longer term guaranteed compatibility

## Dependencies
Ruby, bash, git, winetricks

## Installing
All you need to do is clone the repository and run make.rb.

## Supported Platforms
Currently only tested on macOS 10.12 and 10.13, however Linux and *BSD will both be supported as well. Windows is probably supported through the Linux subsystem but I'm not sure why you would want to run Wine on Windows (I am in no rush to test it).

## Contributing
Pull requests are welcome! If an issue doesn't already exist please open one so we can discuss changes.