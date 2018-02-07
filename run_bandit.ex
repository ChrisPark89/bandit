#!/usr/bin/expect -f
set num [lrange $argv 0 0]
set pass [lrange $argv 1 1]
set server "bandit.labs.overthewire.org"
set port 2220

spawn ssh bandit$num@$server -p $port
match_max 100000
expect "*?assword:*"
send -- "$pass\r"
send -- "\r"
interact
