import XCTest

@testable import Nanomsg

class PipelineTests: XCTestCase {
    let addr = "ipc:///tmp/pipeline.ipc"

    func testPipeline() {
        let push = try! Socket(.PUSH)
        _ = try! push.connect(addr)
        let pull = try! Socket(.PULL)
        _ = try! pull.bind(addr)

        let str = "dadada"

        XCTAssertEqual(try! push.send(str), str.count + 1)
        XCTAssertEqual(try! pull.recv(), str)
    }

    #if !os(OSX)
        static let allTests = [
            ("testPipeline", testPipeline),
        ]
    #endif
}
