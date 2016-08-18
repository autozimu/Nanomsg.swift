import XCTest
import Foundation

@testable import Nanomsg

class BusTests: XCTestCase {
    let addr0 = "ipc:///tmp/bus0.ipc"
    let addr1 = "ipc:///tmp/bus1.ipc"
    let addr2 = "ipc:///tmp/bus2.ipc"

    func testBus() {
        let node0 = try! Socket(.BUS)
        _ = try! node0.bind(addr0)
        _ = try! node0.connect(addr1)
        _ = try! node0.connect(addr2)

        let node1 = try! Socket(.BUS)
        _ = try! node1.bind(addr1)
        _ = try! node1.connect(addr0)
        _ = try! node1.connect(addr2)

        let node2 = try! Socket(.BUS)
        _ = try! node2.bind(addr2)
        _ = try! node2.connect(addr0)
        _ = try! node2.connect(addr1)

        usleep(10 * 1000)

#if os(OSX)
        let msg0 = "node0"
        let msg1 = "node11"
        let msg2 = "node222"

        XCTAssertEqual(try! node0.send(msg0), msg0.characters.count + 1)
        XCTAssertEqual(try! node1.send(msg1), msg1.characters.count + 1)
        XCTAssertEqual(try! node2.send(msg2), msg2.characters.count + 1)

        // XCTAssertEqual(try! node0.recvstr(), msg1)
        // XCTAssertEqual(try! node0.recvstr(), msg2)

        // XCTAssertEqual(try! node1.recvstr(), msg0)
        // XCTAssertEqual(try! node1.recvstr(), msg2)

        // XCTAssertEqual(try! node2.recvstr(), msg0)
        // XCTAssertEqual(try! node2.recvstr(), msg1)
#endif
    }

#if !os(OSX)
    static let allTests = [
        ("testBus", testBus),
    ]
#endif
}
