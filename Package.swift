import PackageDescription

let package = Package(
    name: "Nanomsg",
    dependencies: [
        .Package(url: "../CNanomsg", majorVersion: 0)
    ]
)
