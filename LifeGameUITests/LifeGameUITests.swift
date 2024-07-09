//
//  LifeGameUITests.swift
//  LifeGameUITests
//
//  Created by Nikita Starygin on 08.07.2024.
//

import XCTest

import LifeGameUITestsSupport

final class LifeGameUITests: XCTestCase {
    func testNextGenButtonShouldDisabled_WhenAllCellsDead() throws {
        let gridData = [
            [false, false,  false, false],
            [false,  false, false, false ],
            [false, true,  false, false],
            [false,  false, false, false ],
        ]
        let app = XCUIApplication()
        app.launchArguments = [uiTestsEnabledKey]
        let jsonData = try JSONSerialization.data(
            withJSONObject: gridData,
            options: .prettyPrinted
        )
        app.launchEnvironment[uiTestsCellEnvKey] =  String(data: jsonData, encoding: .utf8)
        app.launch()

        for _ in 0..<3 {
            app.steppers[LifeGameA11yIds.Settings.columnsStepper].stepperIncrementButton?.tap()
        }
        for _ in 0..<3 {
            app.steppers[LifeGameA11yIds.Settings.rowsStepper].stepperIncrementButton?.tap()
        }

        app.buttons[LifeGameA11yIds.Settings.startGame].tap()

        XCTAssert(app.buttons[LifeGameA11yIds.Game.nextGenButton].isEnabled)

        app.buttons[LifeGameA11yIds.Game.nextGenButton].tap()

        XCTAssert(!app.buttons[LifeGameA11yIds.Game.nextGenButton].isEnabled)
    }

    func testGenerationCounter_AfterTappedNextGenTwoTimes() throws {
        let gridData = [
            [false, true,  true, false],
            [false,  true, false, false ],
            [false, true,  false, false],
            [false, true,  true, false]
        ]

        let app = XCUIApplication()
        app.launchArguments = [uiTestsEnabledKey]
        let jsonData = try JSONSerialization.data(
            withJSONObject: gridData,
            options: .prettyPrinted
        )
        app.launchEnvironment[uiTestsCellEnvKey] =  String(data: jsonData, encoding: .utf8)

        step(
            "Launch application",
            block: app.launch
        )

        for _ in 0..<3 {
            step("Tap on increment columns stepper button") {
                app.steppers[LifeGameA11yIds.Settings.columnsStepper].stepperIncrementButton?.tap()
            }
        }
        for _ in 0..<3 {
            step("Tap on increment rows rows button") {
                app.steppers[LifeGameA11yIds.Settings.rowsStepper].stepperIncrementButton?.tap()
            }
        }

        step(
            "Tap on start game button",
            block: app.buttons[LifeGameA11yIds.Settings.startGame].tap
        )

        step("Check next generation button enabled") {
            XCTAssert(app.buttons[LifeGameA11yIds.Game.nextGenButton].isEnabled)
        }

        for _ in 0...1 {
            step(
                "Tap on next generation button",
                block: app.buttons[LifeGameA11yIds.Game.nextGenButton].tap
            )
        }

        try step("Check value in generation counter") {
            let strGenCounterValue = app.staticTexts[LifeGameA11yIds.Game.generationCounter].value as? String
            let genCounterValue = try XCTUnwrap(strGenCounterValue)
            XCTAssertEqual(genCounterValue, "3")
        }
    }
}

private func step(_ named: String, block: @escaping () throws -> Void) rethrows {
    try XCTContext.runActivity(named: named) { _ in
        try block()
    }
}

extension XCUIElement  {
    fileprivate var stepperIncrementButton: XCUIElement? {
        guard elementType == .stepper else { return nil }
        return buttons[identifier + "-Increment"]
    }
}
