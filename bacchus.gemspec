Gem::Specification.new do |s|
  s.name        = 'bacchus-wine'
  s.version     = '0.1.1'
  s.date        = '2018-10-04'
  s.summary     = "A wine application manager"
  s.description = "A CLI utility for installing and managing applications with wine."
  s.authors     = ["Spencer King"]
  s.files = ["lib/bacchus.rb", "lib/bacchus/backup.rb", "lib/bacchus/helpers.rb", "lib/bacchus/init.rb", "lib/bacchus/menu.rb", "lib/bacchus/search.rb", "bin/bacchus"]
  s.executables << 'bacchus'
  s.require_paths = ["lib"]
  s.homepage    =
    'https://github.com/Bacchus-Wine/Bacchus'
  s.add_runtime_dependency 'ncurses-ruby', '~> 1.2.4', '>= 1.2.4'
  s.license       = 'MIT'
end
