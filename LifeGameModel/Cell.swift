//
//  Cell.swift
//  LifeGameModel

import Foundation

public struct Cell: Hashable {
    public let row: Int
    public let column: Int

    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }

    func neighbours() -> Set<Cell> {
        var neighbours = Set<Cell>()
        for row in -1...1 {
            for column in -1...1 {
                neighbours.insert(Cell(
                    row: self.row + row,
                    column: self.column + column
                ))
            }
        }
        neighbours.remove(self)
        return neighbours
    }
}
