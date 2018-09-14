#!/usr/bin/expect -f
#! /bin/bash
proc getScriptDirectory {} {
set dispScriptFile [file normalize [info script]]
set scriptFolder [file dirname $dispScriptFile]
return $scriptFolder
}

# Example usage
set scriptDir [getScriptDirectory]
puts $scriptDir

set command [lindex $argv 0];
send_user "$command\n"
set timeout 30
spawn ssh user@bingsuns.cc.binghamton.edu
expect "*assword*"
send "password\n"
expect "*ingsuns*"
send "$command\n"
expect "*ingsuns*"
send "exit\n"
expect "*cmz*"
spawn scp -P 22 user@bingsuns.cc.binghamton.edu:out.txt $scriptDir
expect "*assword*"
send "password\n"
expect "*100*"
expect eof
