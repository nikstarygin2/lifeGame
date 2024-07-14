//
//  LifeGameUITestsSupport.swift
//  LifeGameUITestsSupport
//
//  Created by Nikita Starygin on 08.07.2024.
//

import Foundation

extension ProcessInfo {
    public static var uiTestsEnabled: Bool {
        processInfo.arguments.contains(uiTestsEnabledKey)
    }

    public static var cellForUITests: [[Bool]]? {
        guard let str  = processInfo.environment[uiTestsCellEnvKey],
              let jsonString = str.data(using: .utf8),
              let boolArray = try? JSONDecoder().decode([[Bool]].self, from: jsonString) else {
            return nil
        }
        return boolArray
    }
}

public let uiTestsCellEnvKey = "ui_tests_cell_env_key"
public let uiTestsEnabledKey = "--ui_tests_enabled"
