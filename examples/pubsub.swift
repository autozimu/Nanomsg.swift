import os

guard Process.argc > 1
    && ((Process.arguments[1] == "server" && Process.argc == 3)
        || (Process.arguments[1] == "client" && Process.argc == 4)) else {
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
    let sock = try Socket(.PUB)
    _ = try sock.bind(Process.arguments[2])

    var i = 0

    while true {
        print("SERVER: PUBLISHING ID \(i)")
        _ = try sock.send("\(i)")
        sleep(1)
        i += 1
    }

} else {
    let sock = try Socket(.SUB)
    _ = try sock.connect(Process.arguments[2])
    sock.sub_subscribe = ""

    while true {
        var msg = try sock.recvstr()
        print("CLIENT \(Process.arguments[3]): RECEIVED \(msg)")
    }
}
