#if os(Linux)
    import GLibc
#else
    import Darwin
#endif

guard Process.argc == 3 && (Process.arguments[1] ==  "node0" || Process.arguments[1] == "node1") else {
    print("Usage: ./pair node0|node1 addr")
    exit(1)
}

let sock = Socket(.AF_SP, .PAIR)
var node0 = false
var node1 = false
if Process.arguments[1] == "node0" {
    node0 = true
    sock.bind(Process.arguments[2])
} else {
    node1 = true
    sock.connect(Process.arguments[2])
}

sock.rcvtimeo = 100

while true {
    print(sock.recvstr())
    sleep(1)
    if node0 {
        sock.send("node0")
    } else {
        sock.send("node1")
    }
}
