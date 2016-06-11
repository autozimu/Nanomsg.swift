import XCTest

import Nanomsg

class PipelineTests: XCTestCase {
    let addr = "ipc:///tmp/pipeline.ipc"
    
    func testPipeline() {
        let push = try! Socket(.PUSH)
        _ = try! push.connect(addr)
        let pull = try! Socket(.PULL)
        _ = try! pull.bind(addr)
        
        let str = "dadada"
        
        XCTAssertEqual(try! push.send(str), 7)
        XCTAssertEqual(try! pull.recvstr(), str)
    }
}