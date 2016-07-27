import XCTest

#if !os(OSX)
public let allTests = [
    testCase(VersionTests.allTests),
    testCase(PipelineTests.allTests),
    testCase(PairTests.allTests),
    testCase(PubSubTests.allTests),
    testCase(SurveyTests.allTests),
    testCase(BusTests.allTests),
]
#endif
