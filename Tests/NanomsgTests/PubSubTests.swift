import XCTest

@testable import Nanomsg

class PubSubTests: XCTestCase {
    let addr = "ipc:///tmp/pubsub.ipc"

    func testPubSub() {
        let server = try! Socket(.PUB)
        _ = try! server.bind(addr)

        let client = try! Socket(.SUB)
        _ = try! client.connect(addr)
        client.sub_subscribe = ""

        #if os(OSX)
            let msg = "yo"

            DispatchQueue(label: "nanomsg").async {
                XCTAssertEqual(try! server.send(msg), msg.count + 1)
            }

            XCTAssertEqual(try! client.recv(), msg)
        #endif
    }

    #if !os(OSX)
        static let allTests = [
            ("testPubSub", testPubSub),
        ]
    #endif
}
