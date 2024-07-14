//
//  WorldTests.swift
//  LifeGameModelTests

import XCTest

@testable import LifeGameModel

final class WorldTests: XCTestCase {
    func testWorldNeighbors() throws {
        let world = try World(columns: 3, rows: 3)
        let neighbours = world.neighbours(for: Cell(row: 0, column: 0))

        XCTAssertEqual(neighbours.count, 3)

        XCTAssertTrue(neighbours.contains(Cell(row: 0, column: 1)))
        XCTAssertTrue(neighbours.contains(Cell(row: 1, column: 0)))
        XCTAssertTrue(neighbours.contains(Cell(row: 1, column: 1)))
    }

    func testWorldNeighbors_WithLoopMode() throws {
        let world = try World(columns: 3, rows: 3, mode: .loop)
        let neighbours = world.neighbours(for: Cell(row: 0, column: 0))

        XCTAssertEqual(neighbours.count, 8)

        XCTAssertTrue(neighbours.contains(Cell(row: 0, column: 1)))
        XCTAssertTrue(neighbours.contains(Cell(row: 1, column: 0)))
        XCTAssertTrue(neighbours.contains(Cell(row: 1, column: 1)))
        XCTAssertTrue(neighbours.contains(Cell(row: 0, column: 2)))
        XCTAssertTrue(neighbours.contains(Cell(row: 2, column: 0)))
        XCTAssertTrue(neighbours.contains(Cell(row: 2, column: 2)))
        XCTAssertTrue(neighbours.contains(Cell(row: 1, column: 2)))
        XCTAssertTrue(neighbours.contains(Cell(row: 2, column: 1)))
    }

    func testGenerationCounter() throws {
        let world = try World(columns: 3, rows: 3)
        world.add(
            [
                Cell(row: 0, column: 0),
                Cell(row: 1, column: 1),
                Cell(row: 0, column: 1)
            ]
        )
        world.nextGeneration()
        world.nextGeneration()

        XCTAssertEqual(world.generationCounter, 3)
    }

    func testGenerationCount_WhenAllCellsDead() throws {
        let world = try World(columns: 3, rows: 3)
        world.add([Cell(row: 0, column: 0)])

        world.nextGeneration()
        world.nextGeneration()

        XCTAssertEqual(world.generationCounter, 2)
    }
}
