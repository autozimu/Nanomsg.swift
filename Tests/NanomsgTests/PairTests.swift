import XCTest

@testable import Nanomsg

class PairTests: XCTestCase {
    let addr = "ipc:///tmp/pair.ipc"

    func testPair() {
        let node0 = try! Socket(.PAIR)
        _ = try! node0.connect(addr)
        let node1 = try! Socket(.PAIR)
        _ = try! node1.bind(addr)

        let hello = "hello"
        XCTAssertEqual(try! node0.send(hello), hello.characters.count + 1)
        XCTAssertEqual(try! node1.recv(), hello)

        let world = "hello"
        XCTAssertEqual(try! node1.send(world), world.characters.count + 1)
        XCTAssertEqual(try! node0.recv(), world)
    }

#if !os(OSX)
    static let allTests = [
        ("testPair", testPair),
    ]
#endif
}
