import XCTest

@testable import Nanomsg

class BusTests: XCTestCase {
    let addr0 = "ipc:///tmp/bus0.ipc"
    let addr1 = "ipc:///tmp/bus1.ipc"
    let addr2 = "ipc:///tmp/bus2.ipc"
    let addr3 = "ipc:///tmp/bus3.ipc"
    
    func testBus() {
        let node0 = try! Socket(.BUS)
        _ = try! node0.bind(addr0)
        _ = try! node0.connect(addr1)
        _ = try! node0.connect(addr2)
        _ = try! node0.connect(addr3)
        
        let node1 = try! Socket(.BUS)
        _ = try! node1.bind(addr1)
        _ = try! node1.connect(addr0)
        _ = try! node1.connect(addr2)
        _ = try! node1.connect(addr3)
        
        let node2 = try! Socket(.BUS)
        _ = try! node2.bind(addr2)
        _ = try! node2.connect(addr0)
        _ = try! node2.connect(addr1)
        _ = try! node2.connect(addr3)
        
        let node3 = try! Socket(.BUS)
        _ = try! node3.bind(addr3)
        _ = try! node3.connect(addr0)
        _ = try! node3.connect(addr1)
        _ = try! node3.connect(addr2)
        
        let msg0 = "node0"
        let msg1 = "node1"
        let msg2 = "node2"
        let msg3 = "node3"
        
        XCTAssertEqual(try! node0.send(msg0), msg0.characters.count + 1)
        XCTAssertEqual(try! node1.send(msg1), msg1.characters.count + 1)
        XCTAssertEqual(try! node2.send(msg2), msg2.characters.count + 1)
        XCTAssertEqual(try! node3.send(msg3), msg3.characters.count + 1)
        
        XCTAssertEqual(try! node0.recvstr(), msg1)
        XCTAssertEqual(try! node0.recvstr(), msg2)
        XCTAssertEqual(try! node0.recvstr(), msg3)
        
        XCTAssertEqual(try! node1.recvstr(), msg0)
        XCTAssertEqual(try! node1.recvstr(), msg2)
        XCTAssertEqual(try! node1.recvstr(), msg3)
        
        XCTAssertEqual(try! node2.recvstr(), msg0)
        XCTAssertEqual(try! node2.recvstr(), msg1)
        XCTAssertEqual(try! node2.recvstr(), msg3)
        
        XCTAssertEqual(try! node3.recvstr(), msg0)
        XCTAssertEqual(try! node3.recvstr(), msg1)
        XCTAssertEqual(try! node3.recvstr(), msg2)
    }
    
#if !os(OSX)
    static let allTests = [
        ("testBus", testBus),
    ]
#endif
}
