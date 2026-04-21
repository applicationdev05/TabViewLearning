//
//  TabNavigationStateTests.swift
//  TabViewAndRoutingTests
//
//  Created by Rajat on 19/04/26.
//

import Combine
import XCTest
@testable import TabViewAndRouting

@MainActor
final class TabNavigationStateTests: XCTestCase {

    var sut: TabNavigationState<String>!

    override func setUp() {
        super.setUp()
        sut = TabNavigationState<String>()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_push_addsRouteToPath() {
        sut.push("A")
        XCTAssertEqual(sut.path, ["A"])
    }

    func test_pop_removesLastRoute() {
        sut.path = ["A", "B"]
        sut.pop()
        XCTAssertEqual(sut.path, ["A"])
    }

    func test_pop_doesNothing_whenEmpty() {
        sut.pop()
        XCTAssertTrue(sut.path.isEmpty)
    }

    func test_popToRoot_clearsPath() {
        sut.path = ["A", "B", "C"]
        sut.popToRoot()
        XCTAssertTrue(sut.path.isEmpty)
    }

    func test_popTo_keepsTargetRoute() {
        sut.path = ["A", "B", "C", "D"]
        sut.popTo("B")
        XCTAssertEqual(sut.path, ["A", "B"])
    }

    func test_popTo_inclusive_removesTargetRoute() {
        sut.path = ["A", "B", "C", "D"]
        sut.popTo("B", inclusive: true)
        XCTAssertEqual(sut.path, ["A"])
    }

    func test_popTo_doesNothing_ifRouteNotFound() {
        sut.path = ["A", "B"]
        sut.popTo("Z")
        XCTAssertEqual(sut.path, ["A", "B"])
    }
}
