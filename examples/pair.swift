import os

guard Process.argc == 3 && (Process.arguments[1] == "node0" || Process.arguments[1] == "node1") else {
    print("Usage: ./pair node0|node1 addr")
    exit(1)
}

let sock = try Socket(.PAIR)
var node0 = false
var node1 = false
if Process.arguments[1] == "node0" {
    node0 = true
    try sock.bind(Process.arguments[2])
} else {
    node1 = true
    try sock.connect(Process.arguments[2])
}

sock.rcvtimeo = 100

while true {
    do {
        try print(sock.recvstr())
    }
    catch NanomsgError.Err(let errno, _) {
        // timeout
        assert(errno == 60)
    }
    sleep(1)
    if node0 {
        try sock.send("node0")
    } else {
        try sock.send("node1")
    }
}
