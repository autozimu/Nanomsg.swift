// Pull
let socket = Socket(domain: .AF_SP, proto: .PULL)
socket.bind(addr: "ipc:///tmp/pipeline.ipc")

print(socket.recvstr())
