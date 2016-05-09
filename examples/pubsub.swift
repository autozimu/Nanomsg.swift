#if os(Linux)
    import GLibc
#else
    import Darwin
#endif

guard Process.argc > 1
        && (Process.arguments[1] == "server" && Process.argc == 3)
        || (Process.arguments[1] == "client" && Process.argc == 4) else {
    print("Usage: ./pubsub server [addr]")
    print("Usage: ./pubsub client [addr] [name]")
    exit(1)
}
var server = false
var client = false
if Process.arguments[1] == "server" {
    server = true
} else {
    client = true
}


if server {
    let sock = Socket(.AF_SP, .PUB)
    sock.bind(Process.arguments[2])

    var i = 0

    while true {
        print("SERVER: PUBLISHING ID \(i)")
        sock.send("\(i)")
        sleep(1)
        i += 1
    }

} else {
    let sock = Socket(.AF_SP, .SUB)
    sock.connect(Process.arguments[2])

    while true {
        var msg = sock.recvstr()
        print("CLIENT \(Process.arguments[3]): RECEIVED \(msg)")
    }
}
