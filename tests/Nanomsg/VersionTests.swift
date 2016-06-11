import XCTest

import Nanomsg

class VersionTests: XCTestCase {
    func testVersion() {
        XCTAssertEqual(NN_VERSION_CURRENT, 4)
        XCTAssertEqual(NN_VERSION_REVISION, 0)
        XCTAssertEqual(NN_VERSION_AGE, 0)
    }
}
