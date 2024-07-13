//
//  WorldTests.swift
//  LifeGameModelTests

import XCTest

@testable import LifeGameModel

final class WorldTests: XCTestCase {
    func test_CalculateCellsNeighbors() {
        // Arrange
        let world = World(columns: 3, rows: 3)

        // Act
        let neighbours = world.calculateNeighbours(for: Cell(row: 0, column: 0))
        
        // Assert
        XCTAssertEqual(neighbours.count, 3)

        XCTAssertTrue(neighbours.contains(Cell(row: 0, column: 1)))
        XCTAssertTrue(neighbours.contains(Cell(row: 1, column: 0)))
        XCTAssertTrue(neighbours.contains(Cell(row: 1, column: 1)))
    }
}
