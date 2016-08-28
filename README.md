# Swift binding for [nanomsg](http://nanomsg.org/)
[![Build Status](https://travis-ci.org/autozimu/Nanomsg.swift.svg?branch=master)](https://travis-ci.org/autozimu/Nanomsg.swift)

## Usage

If [Swift Package Manager](https://github.com/apple/swift-package-manager) is
used, add this package as a dependency in `Package.swift`,

```swift
.Package(url: "https://github.com/autozimu/Nanomsg.swift.git", majorVersion: 0)
```

## Example

Push
```swift
import Nanomsg

let sock = try Socket(.PUSH)
try sock.connect("ipc:///tmp/pipeline.ipc")
try sock.send("Yo!")
```

Pull

```swift
import Nanomsg

let sock = try Socket(.PULL)
try sock.bind("ipc:///tmp/pipeline.ipc")
let msg: String = try sock.recv()
print(msg) // Yo!
```

More examples could be found in examples dir.

## Documentation

<https://autozimu.github.io/Nanomsg.swift/>
