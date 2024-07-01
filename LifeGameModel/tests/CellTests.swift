//
//  CellTests.swift
//  LifeGameModelTests

import XCTest

@testable import LifeGameModel

final class CellTests: XCTestCase {
    private let row = 4
    private let column = 4
    private var cell: Cell!

    override func setUp() {
        super.setUp()
        cell = Cell(row: row, column: column)
    }

    func testNeighbours() {
        let neighbours: Set<Cell> = cell.neighbours()

        XCTAssertTrue(neighbours.contains(Cell(row: row-1, column: column-1)))
        XCTAssertTrue(neighbours.contains(Cell(row: row-1, column: column)))
        XCTAssertTrue(neighbours.contains(Cell(row: row-1, column: column+1)))
        XCTAssertTrue(neighbours.contains(Cell(row: row, column: column-1)))
        XCTAssertTrue(neighbours.contains(Cell(row: row, column: column+1)))
        XCTAssertTrue(neighbours.contains(Cell(row: row+1, column: column-1)))
        XCTAssertTrue(neighbours.contains(Cell(row: row+1, column: column)))
        XCTAssertTrue(neighbours.contains(Cell(row: row+1, column: column+1)))
    }

    func testNeighboursHaveNotSelf() {
        let neighbours: Set<Cell> = cell.neighbours()
        XCTAssertFalse(neighbours.contains(cell))
    }
}
