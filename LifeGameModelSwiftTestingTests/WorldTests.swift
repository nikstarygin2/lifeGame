//
//  WorldTests.swift
//  LifeGameModelSwiftTestingTests
//
//  Created by Nikita Starygin on 08.07.2024.
//

import Testing

@testable import LifeGameModel

@Suite("Tests cell's neigbours in world", .tags(.world))
struct CellNeighboursTests {
    @Test("World with loop mode")
    func loop() throws {
        let world = try World(columns: 3, rows: 3, mode: .loop)
        let neighbours = world.neighbours(for: Cell(row: 0, column: 0))

        try #require(neighbours.count == 8)

        #expect(neighbours.contains(Cell(row: 0, column: 1)))
        #expect(neighbours.contains(Cell(row: 1, column: 0)))
        #expect(neighbours.contains(Cell(row: 1, column: 1)))
        #expect(neighbours.contains(Cell(row: 0, column: 2)))
        #expect(neighbours.contains(Cell(row: 2, column: 0)))
        #expect(neighbours.contains(Cell(row: 2, column: 2)))
        #expect(neighbours.contains(Cell(row: 1, column: 2)))
        #expect(neighbours.contains(Cell(row: 2, column: 1)))
    }

    @Test("World with simple mode")
    func simple() throws {
        let world = try World(columns: 3, rows: 3)
        let neighbours = world.neighbours(for: Cell(row: 0, column: 0))

        try #require(neighbours.count == 3)

        #expect(neighbours.contains(Cell(row: 0, column: 1)))
        #expect(neighbours.contains(Cell(row: 1, column: 0)))
        #expect(neighbours.contains(Cell(row: 1, column: 1)))
    }
}

extension Tag {
    @Tag static var world: Self
}
