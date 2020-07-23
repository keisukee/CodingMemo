register read
register read $rsp
p/x *(long *)$rsp
p/x $rsp
register read /x $rsp
b getbuf
breakpoint list
continue
run
finish

