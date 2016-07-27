import XCTest

@testable import Nanomsg

class PubSubTests: XCTestCase {
    let addr = "ipc:///tmp/pubsub.ipc"

    func testPubSub() {
        let client = try! Socket(.SUB)
        _ = try! client.connect(addr)

        let server = try! Socket(.PUB)
        _ = try! server.bind(addr)
        
        let msg = "yo"
        
        // FIXME
        return
        
        XCTAssertEqual(try! server.send(msg), msg.characters.count + 1)
        XCTAssertEqual(try! client.recvstr(), msg)
    }
    
#if !os(OSX)
    static var allTests = [
        ("testPubSub", testPubSub),
    ]
#endif
}
