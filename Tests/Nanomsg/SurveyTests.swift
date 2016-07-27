import XCTest

@testable import Nanomsg

class SurveyTests: XCTestCase {
    let addr = "ipc:///tmp/survey.ipc"

    func testSurvey() {
        let surveyor = try! Socket(.SURVEYOR)
        _ = try! surveyor.bind(addr)
        
        let respondent = try! Socket(.RESPONDENT)
        _ = try! respondent.connect(addr)
        
        // FIXME
        return
        
        var msg = "this is survey"
        
        XCTAssertEqual(try! surveyor.send(msg), msg.characters.count + 1)
        XCTAssertEqual(try! respondent.recvstr(), msg)
        
        msg = "this is response"
        
        XCTAssertEqual(try! respondent.send(msg), msg.characters.count + 1)
        XCTAssertEqual(try! surveyor.recvstr(), msg)
    }
    
#if !os(OSX)
    static var allTests = [
        ("testSurvey", testSurvey),
    ]
#endif
}
