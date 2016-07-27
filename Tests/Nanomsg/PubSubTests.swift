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
        
        // FIXME
        return

        let msg = "yo"

        XCTAssertEqual(try! server.send(msg), msg.characters.count + 1)
        XCTAssertEqual(try! client.recvstr(), msg)
    }
    
#if !os(OSX)
    static var allTests = [
        ("testPubSub", testPubSub),
    ]
#endif
}
