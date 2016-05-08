#if os(Linux)
    import GLibc
#else
    import Darwin
#endif

guard (Process.argc == 3 && Process.arguments[1] ==  "node0")
        || (Process.argc == 4 && Process.arguments[1] == "node1") else {
    print("Usage: ./pipeline node0 addr")
    print("Usage: ./pipeline node1 addr msg")
    exit(1)
}
var node0 = false
var node1 = false
if Process.arguments[1] == "node0" {
    node0 = true
} else {
    node1 = true
}


if node0 {
    let sock = Socket(.AF_SP, .PULL)
    sock.bind(Process.arguments[2])

    while true {
        if let msg = sock.recvstr() {
            print("RECEIVED: " + msg)
        }
    }

} else {
    let sock = Socket(.AF_SP, .PUSH)
    sock.connect(Process.arguments[2])

    let msg = Process.arguments[3]
    print("SENDING: " + msg)
    sock.send(msg)
}
