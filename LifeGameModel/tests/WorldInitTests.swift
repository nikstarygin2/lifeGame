//
//  WorldInitTests.swift
//  LifeGameModelTests
//
//  Created by Nikita Starygin on 08.07.2024.
//

import XCTest

@testable import LifeGameModel

final class WorldInitTests: XCTestCase {
    func testWorldInitialization() throws {
        let cells: Set<Cell> = [ Cell(row: 0, column: 0) ]

        for size in 1...10 {
            let world = try World(columns: size, rows: size)
            world.add(cells)
            XCTAssertEqual(world.aliveCells, cells)
        }
    }

    func testWorldInitialization_WithError() {
        for size in -1...0 {
            do {
                let _ = try World(columns: size, rows: size)
            } catch {
                XCTAssertEqual(error as! WorldInitializationErrors, WorldInitializationErrors.invalidSize)
            }
        }
    }
}
