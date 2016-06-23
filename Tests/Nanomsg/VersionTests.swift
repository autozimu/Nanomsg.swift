import XCTest

import Nanomsg

class VersionTests: XCTestCase {
    func testVersion() {
        XCTAssertEqual(NN_VERSION_CURRENT, 5)
        XCTAssertEqual(NN_VERSION_REVISION, 0)
        XCTAssertEqual(NN_VERSION_AGE, 0)
    }

#if !os(OSX)
    static var allTests = [
            ("testVersion", testVersion)
    ]
#endif
}

