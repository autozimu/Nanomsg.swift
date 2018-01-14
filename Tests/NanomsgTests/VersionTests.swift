import XCTest

import Nanomsg

class VersionTests: XCTestCase {

    func testVersion() {
        XCTAssertEqual(NN_VERSION_CURRENT, 5)
        XCTAssertEqual(NN_VERSION_REVISION, 1)
        XCTAssertEqual(NN_VERSION_AGE, 0)
    }

    #if !os(OSX)
        static let allTests = [
            ("testVersion", testVersion),
        ]
    #endif
}
