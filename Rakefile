require "bundler/gem_tasks"
require File.join(File.dirname(__FILE__), 'lib/better_served_printer')

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r ./lib/better_served_printer.rb"
end

task :package do
  sh "rm -f *.deb"
  name = "better_served_printer-#{BetterServedPrinter::VERSION}.gem"
  sh "rm -f #{name}"
  sh "rm -f rubygem-better-served-printer_#{BetterServedPrinter::VERSION}_all.deb"
  Rake::Task["build"].invoke

  # package gem
  init_script = "./scripts/init.d/better_served_printer"
  post_install_script = 'scripts/postinst'
  prerem_script = 'scripts/prerem'
  before_install_script = 'scripts/preinstall'

  cmd = "fpm -s dir -t deb --no-depends -a all"
  cmd = "--prefix /usr/share/ "
  cmd += " --deb-init #{init_script}"
  cmd += " --after-install #{post_install_script}"
  cmd += " --after-remove #{prerem_script}"
  cmd += " --before-install #{before_install_script}"
  cmd += ' -n better_served_printer'
  cmd += " pkg/"

  puts cmd
  sh cmd

  # package dependencies
  #Rake::Task["package_dependencies"].invoke
end

task :package_dependencies do
  sh "rm -rf tmp/gems"
  sh "gem install --no-ri --no-rdoc --install-dir tmp/gems pkg/better_served_printer-#{BetterServedPrinter::VERSION}.gem"
  sh "rm -f tmp/gems/cache/better_served_printer-#{BetterServedPrinter::VERSION}.gem"
  sh "find tmp/gems/cache -name '*.gem' | xargs -rn1 fpm -s gem -t deb -a all"
end