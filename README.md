Swift binding for [nanomsg](http://nanomsg.org/)

### Usage

If [Swift Package Manager](https://github.com/apple/swift-package-manager) is
used, add this package as a dependency in `Package.swift`,

    .Package(url: "https://github.com/autozimu/Nanomsg-swift.git", majorVersion: 0)

### Example

Push

    import Nanomsg

    let sock = try Socket(.PUSH)
    try sock.connect("ipc:///tmp/pipeline.ipc")
    try sock.send("Yo!")

Pull

    import Nanomsg

    let sock = try Socket(.PULL)
    try sock.bind("ipc:///tmp/pipeline.ipc")
    try print(sock.recvstr())

More examples could be found in examples dir.

### Documentation

<http://autozimu.github.io/Nanomsg-swift/>
