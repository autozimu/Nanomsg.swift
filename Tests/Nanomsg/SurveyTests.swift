import XCTest

@testable import Nanomsg

class SurveyTests: XCTestCase {
    let addr = "ipc:///tmp/survey.ipc"

    func testSurvey() {
        let surveyor = try! Socket(.SURVEYOR)
        _ = try! surveyor.bind(addr)
        
        let respondent = try! Socket(.RESPONDENT)
        _ = try! respondent.connect(addr)
        
#if !os(OSX)
        return
#endif

        let queue = DispatchQueue(label: "nanomsg")
        
        var msg = "this is survey"
        
        queue.async {
            XCTAssertEqual(try! surveyor.send(msg), msg.characters.count + 1)
        }
        XCTAssertEqual(try! respondent.recvstr(), msg)
        
        msg = "this is response"

        queue.async {
            XCTAssertEqual(try! respondent.send(msg), msg.characters.count + 1)
        }
        XCTAssertEqual(try! surveyor.recvstr(), msg)
    }
    
#if !os(OSX)
    static let allTests = [
        ("testSurvey", testSurvey),
    ]
#endif
}
