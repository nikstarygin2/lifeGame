//
//  LifeGameModelSwiftTestingTests.swift
//  LifeGameModelSwiftTestingTests
//
//  Created by Nikita Starygin on 08.07.2024.
//

import Testing

@testable import LifeGameModel

@Test("Check cell's neighbours")
func checkNeighbours() {
    let row = 4
    let column = 4
    let cell = Cell(row: row, column: column)

    let neighbours: Set<Cell> = cell.neighbours()

    #expect(neighbours.contains(Cell(row: row-1, column: column-1)))
    #expect(neighbours.contains(Cell(row: row-1, column: column)))
    #expect(neighbours.contains(Cell(row: row-1, column: column+1)))
    #expect(neighbours.contains(Cell(row: row, column: column-1)))
    #expect(neighbours.contains(Cell(row: row, column: column+1)))
    #expect(neighbours.contains(Cell(row: row+1, column: column-1)))
    #expect(neighbours.contains(Cell(row: row+1, column: column)))
    #expect(neighbours.contains(Cell(row: row+1, column: column+1)))
}
