#!/usr/bin/expect -f
spawn <run the command>
expect "<Command prompt expected>:" #Include exact command prompt including colon 
send "<expected input>\r"
interact
