import PackageDescription

let package = Package(
    name: "test",
    dependencies: [
        .Package(url: "./CNanomsg", majorVersion: 0)
    ]
)
