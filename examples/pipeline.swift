import os

guard (Process.argc == 3 && Process.arguments[1] == "node0")
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
    let sock = try Socket(.PULL)
    try sock.bind(Process.arguments[2])

    while true {
        if let msg = try sock.recvstr() {
            print("RECEIVED: " + msg)
        }
    }

} else {
    let sock = try Socket(.PUSH)
    try sock.connect(Process.arguments[2])

    let msg = Process.arguments[3]
    print("SENDING: " + msg)
    try sock.send(msg)
}
