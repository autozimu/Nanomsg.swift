// Push
let socket = Socket(domain: .AF_SP, proto: .PUSH)
socket.connect(addr: "ipc:///tmp/pipeline.ipc")

socket.send(msg: "Yo")
