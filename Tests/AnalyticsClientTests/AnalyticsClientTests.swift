import XCTest

@testable import AnalyticsClient

final class AnalyticsClientTests: XCTestCase {
  func testDefaultClient() throws {
    let event = AnalyticsEvent(name: "test_run")

    var destination1Called = false
    let destination1 = AnalyticsDestination {
      XCTAssertEqual(event, $0)
      destination1Called = true
    }

    var destination2Called = false
    let destination2 = AnalyticsDestination {
      XCTAssertEqual(event, $0)
      destination2Called = true
    }

    let client = AnalyticsClient.default([destination1, destination2])
    client.track(event)

    XCTAssertEqual([destination1Called, destination2Called], [true, true])
  }
}
