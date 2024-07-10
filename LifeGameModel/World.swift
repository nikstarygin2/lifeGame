//
//  World.swift
//  LifeGameModel

import Foundation

public final class World {
    public let rows: Int
    public let columns: Int
    public private(set) var aliveCells: Set<Cell> = []

    public init(
        columns: Int,
        rows: Int
    ) {
        self.columns = columns
        self.rows = rows
    }

    public func add(_ cells: Set<Cell>) {
        aliveCells.formUnion(cells.filter(isWordContainCell))
    }

    public func nextGeneration() {
        var cellsWithNeighbours = cellsWithNeighbours()
        var newCells: Set<Cell> = []

        // если у живой клетки есть две или три живые соседки, то эта клетка продолжает жить
        for cell in aliveCells {
            if let count = cellsWithNeighbours.removeValue(forKey: cell), (count == 2 || count == 3) {
                newCells.insert(cell)
            }
        }

        // в пустой (мёртвой) клетке, с которой соседствуют три живые клетки, зарождается жизнь;
        for (cell, count) in cellsWithNeighbours {
            guard count == 3 else { continue }
            newCells.insert(cell)
        }

        // в противном случае (если живых соседей меньше двух или больше трёх)
        // клетка умирает («от одиночества» или «от перенаселённости»).

        aliveCells = newCells
    }

    func neighbours(for cell: Cell) -> Set<Cell> {
        Set(cell.neighbours().filter(isWordContainCell))
    }

    private func cellsWithNeighbours() -> [Cell: Int] {
        var dict: [Cell: Int] = [:]

        for cell in aliveCells {
            for neighbour in neighbours(for: cell) {
                dict[neighbour, default: 0] += 1
            }
        }

        return dict
    }

    private func isWordContainCell(_ cell: Cell) -> Bool {
        (cell.row >= 0 && cell.row < rows) && (cell.column >= 0 && cell.column < columns)
    }
}
