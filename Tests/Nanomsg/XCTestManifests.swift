import XCTest

#if !os(OSX)
public let allTests = [
    testCase(VersionTests.allTests),
    testCase(PipelineTests.allTests),
]
#endif