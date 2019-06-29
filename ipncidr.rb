# IP.N.CIDR
#
# The same group you love to hate, to love, to hate ...
# 
# check OS
require 'os'
def checkos
  return "linux" if OS.linux?   #=> true or false
  return "windows" if OS.windows? #=> true or false
  return "java" if OS.java?    #=> true or false
  #return "bsd" if OS.bsd?     #=> true or false might be bad
  return "mac" if OS.mac?     #=> true or false
end
$oasis = checkos
# 
if ["linux","mac"].include? $oasis
  require 'etc'
  if Etc.getpwuid.uid != 0
    puts "We're going to need you to be 'root' or 'sudo', kthnx, bye"
    exit 1
  else
    puts "Running in privileged mode"
    # Do stuff only superuser can do
  end
end
puts "ENTERING MAIN" if $dev
$r={}
$r[:banner] = method(
  def shellout
    a= [
    "0a0a1b5b303b33313b34396d2c2e2d7e2ac2b4c2a8c2afc2a8602ac2b77e2d2e" +
    "c2b81b5b306d1b5b303b39373b34396d2d281b5b306d1b5b303b33333b34396d" +
    "62791b5b306d1b5b303b39373b34396d292d1b5b306d1b5b303b33313b34396d" +
    "2c2e2d7e2ac2b4c2a8c2afc2a8602ac2b77e2d2ec2b81b5b306d0a1b5b303b33" +
    "343b34396d0a0a0a202020202020202020e2968020e2968820e2968820e29688" +
    "e29680e29684e29680e29688201b5b306d1b5b303b33313b34396de29688e296" +
    "80e29680e29688201b5b306d1b5b303b33343b34396de29688e29680e29680e2" +
    "96840a1b5b306d1b5b303b33343b34396d202020202020202020e2968820e296" +
    "8820e2968820e2968820e2968020e29688201b5b306d1b5b303b33313b34396d" +
    "e296882020e29688201b5b306d1b5b303b33343b34396de29688e29680e29680" + 
    "e296840a1b5b306d1b5b303b33343b34396d202020202020202020e2968020e2" + 
    "968020e2968020e29680202020e29680201b5b306d1b5b303b33313b34396de2" +
    "9680e29680e29680e29680201b5b306d1b5b303b33343b34396de29680e29680" +
    "e296800a1b5b306d1b5b303b33333b34396d2020202020202020202068747470" +
    "733a2f2f696c6c6d6f622e6f72671b5b306d0000000000000000000000000000"
    ].pack("H*")
  end)
#[STRUCTURE]###################################################################################################################################
$r[:init] = {:main => 0,:opts => 0}
$r[:system] = {} 
$r[:plugins] = {}
$r[:modules] = {}
$r[:questions] = {}
$r[:input] = {}
$r[:output] = {}
$r[:output][:internal] = {}
$r[:output][:internal][:ipv4] = {:cidr => [], :ipaddr => [], :decimal => [], :loopback => [], :broadcast => [], :bogo => [], :forward => [], :reverse => []}
$r[:output][:internal][:ipv6] = {:cidr => [], :ipaddr => [], :decimal => [], :loopback => [], :broadcast => [], :bogo => [], :forward => [], :reverse => []}
$r[:output][:external] = {}
$r[:output][:external][:ipv4] = {:cidr => [], :ipaddr => [], :decimal => [], :loopback => [], :broadcast => [], :bogo => [], :forward => [], :reverse => []}
$r[:output][:external][:ipv6] = {:cidr => [], :ipaddr => [], :decimal => [], :loopback => [], :broadcast => [], :bogo => [], :forward => [], :reverse => []}
$r[:output][:invalid] = {}
$r[:output][:invalid][:unsorted] = {:data => []}
$r[:output][:whois] = {}
$r[:errors] = {}
$r[:mmm ] = {}
puts "INITIAL SYSTEM HASH:" if $dev
# requires whois 3.0 (NOT 4.0)
# OptionParser
#[GEMREQUIRE]#################################################################################################################################
["timeout","socket","nmap","resolv","colorize","yaml","optparse","ostruct","nokogiri","json","httparty","netaddr","ipaddr","IPAddress", "whois"].each { | basemod | 
  begin
    require basemod
  rescue => gemloadfailed
    puts "Failed to load GEM: #{basemod}: #{gemloadfailed}" if $dev
    puts "Ensure all required 3rd party Gems are installed" if $dev
  end
}
#[MODULELOADER]#################################################################################################################################
def LoadMods(directory)
  begin
    imports = Dir.glob(directory).sort 
    imports.each { |e| puts "#{e}" if $dev; require_relative "#{e}" if File.file? e }
  rescue =>errorhere
    puts errorhere if $dev
  end
end
#[ACTION]#####################################################################################################################################
puts "LOADING MODULES" if $dev
LoadMods("./modules/SYSTEM/*")
LoadMods("./modules/UI/*")
puts "LOADING PLUGINS"  if $dev
LoadMods("./plugins/**/*")
#[MENU]#####################################################################################################################################
puts "STARTING APPLICATION" if $dev
$r[:system][:userops].()
$r[:system][:app][:cli][:mainmenu].()
