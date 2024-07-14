//
//  World.swift
//  LifeGameModel

import Foundation

public final class World {
    public let rows: Int
    public let columns: Int
    public private(set) var generationCounter = 1
    public private(set) var aliveCells: Set<Cell> = []
    private let mode: WorldMode

    public init(
        columns: Int,
        rows: Int,
        mode: WorldMode = .simple
    ) throws {
        guard columns > 0, rows > 0 else {
            throw WorldInitializationErrors.invalidSize
        }
        self.columns = columns
        self.rows = rows
        self.mode = mode
    }

    public func add(_ cells: Set<Cell>) {
        aliveCells.formUnion(cells.filter(isWordContainCell))
    }

    public func nextGeneration() {
        guard !aliveCells.isEmpty else { return }
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
        
        generationCounter += 1
        aliveCells = newCells
    }

    func neighbours(for cell: Cell) -> Set<Cell> {
        let neighbours: [Cell]

        switch mode {
        case .simple:
            neighbours = cell.neighbours().filter(isWordContainCell)
        case .loop:
            neighbours = cell.neighbours().map { neighbour in
                Cell(
                    row: (neighbour.row + rows) % rows,
                    column: (neighbour.column + columns) % columns
                )
            }
            .filter { $0 != cell }
        }

        return Set(neighbours)
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

enum WorldInitializationErrors: Error {
    case invalidSize
}

