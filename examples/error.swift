let socket = Socket(domain: .AF_SP, proto: .PULL)

print(socket.errno)

assert(socket.strerror(1) == "Operation not permitted")
