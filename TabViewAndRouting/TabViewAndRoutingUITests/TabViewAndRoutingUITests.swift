//
//  TabViewAndRoutingUITests.swift
//  TabViewAndRoutingUITests
//
//  Created by Rajat on 16/07/26.
//

import XCTest

final class TabViewAndRoutingUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
        openLoggedOutStart()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func test_authNavigation_canOpenSignupAndReturnToLogin() {
        XCTAssertTrue(app.staticTexts["Login Screen"].waitForExistence(timeout: 2))

        app.buttons["Sign Up"].tap()
        XCTAssertTrue(app.staticTexts["Sign Up Screen"].waitForExistence(timeout: 2))

        app.buttons["Back to Login"].tap()
        XCTAssertTrue(app.staticTexts["Login Screen"].waitForExistence(timeout: 2))
    }

    func test_loggedInUser_canSwitchAcrossMainTabs() {
        app.buttons["Login (demo)"].tap()
        XCTAssertTrue(app.staticTexts["Home Screen"].waitForExistence(timeout: 2))

        app.tabBars.buttons["Search"].tap()
        XCTAssertTrue(app.textFields["Search"].waitForExistence(timeout: 2))

        app.tabBars.buttons["Profile"].tap()
        XCTAssertTrue(app.staticTexts["Profile"].waitForExistence(timeout: 2))

        app.tabBars.buttons["Settings"].tap()
        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 2))
    }

    private func openLoggedOutStart() {
        if app.staticTexts["Login Screen"].waitForExistence(timeout: 1) {
            return
        }

        app.tabBars.buttons["Profile"].tap()
        app.buttons["Logout"].tap()
        XCTAssertTrue(app.staticTexts["Login Screen"].waitForExistence(timeout: 2))
    }
}
