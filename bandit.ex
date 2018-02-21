#!/usr/bin/expect -f

set server "bandit.labs.overthewire.org"
set port 2220

set num [lrange $argv 0 0]
set pass [lrange $argv 1 1]
set found 0

###read password for the matching number from the password file
set f [open "password"]
while {![eof $f]} {
  set credential [split [gets $f] " "]
  set f_num [lindex $credential 0]
  set f_pass [lindex $credential 1]

  if { $num == $f_num } {
    set pass $f_pass
    set found 1
    break
  }
}
close $f
set len_pass [llength $pass]

if {$len_pass == 0} {
  puts "\nError: There is no password for bandit$num\n"
  exit
} elseif {$found == 0} {
  exec echo $num $pass >> password
} else {
  puts "\n***Password was found in the file***\n"
}


###connect ssh
spawn ssh bandit$num@$server -p $port
match_max 100000
expect "*?assword:*"
send -- "$pass\r"
send -- "\r"
interact
