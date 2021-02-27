import XCTest
@testable import Article

final class ArticleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Article().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample), 
    ]
}
