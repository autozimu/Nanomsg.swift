import PackageDescription

let package = Package(
    name: "Nanomsg",
    dependencies: [
        .Package(url: "https://github.com/autozimu/CNanomsg.git", majorVersion: 0),
    ]
)
