//
//  WorldGenerationTests.swift
//  LifeGameModelTests
//
//  Created by Nikita Starygin on 08.07.2024.
//

import XCTest

@testable import LifeGameModel

final class WorldGenerationTests: XCTestCase {
    private let world = try! World(columns: 10, rows: 10)

    func testBlockGeneration() {
        let cells: Set<Cell> = [
            Cell(row: 1, column: 1),
            Cell(row: 1, column: 2),
            Cell(row: 2, column: 1),
            Cell(row: 2, column: 2)
        ]
        world.add(cells)

        for _ in 0..<100 {
            world.nextGeneration()
        }

        XCTAssertEqual(cells, world.aliveCells)
    }

    func testHiveGeneration() {
        let cells: Set<Cell> = [
            Cell(row: 3, column: 3),
            Cell(row: 3, column: 4),
            Cell(row: 4, column: 2),
            Cell(row: 4, column: 5),
            Cell(row: 5, column: 3),
            Cell(row: 5, column: 4),
        ]

        world.add(cells)

        for _ in 0..<100 {
            world.nextGeneration()
        }

        XCTAssertEqual(cells, world.aliveCells)
    }

    func testNewCells() throws {
        let world = try World(columns: 5, rows: 5)
        let cells: Set<Cell> = [
            Cell(row: 0, column: 0),
            Cell(row: 0, column: 1),
            Cell(row: 0, column: 2)
        ]
        world.add(cells)

        world.nextGeneration()
        XCTAssertEqual(world.aliveCells, [
            Cell(row: 0, column: 1),
            Cell(row: 1, column: 1)
        ])
    }
}
