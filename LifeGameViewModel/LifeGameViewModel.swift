//
//  LifeGameViewModel.swift
//  LifeGameViewModel

import Observation
import Foundation

import LifeGameModel

@Observable
public final class LifeViewModel {
    private let rows: Int
    private let columns: Int
    private let world: World
    private var timer: Timer?
    public var generationCounter: Int

    public var gridData: [[Bool]] {
        didSet {
            generationCounter = world.generationCounter
        }
    }

    public func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.nextGen()
        }
    }

    public func nextGen() {
        world.nextGeneration()
        var newGridData = Array(
            repeating: Array(repeating: false, count: columns),
            count: rows
        )
        for cell in world.aliveCells {
            newGridData[cell.row][cell.column] = true
        }
        gridData = newGridData
    }

    public func setCells(_ cells: Set<Cell>) {
        world.add(cells)
        for cell in world.aliveCells {
            gridData[cell.row][cell.column] = true
        }
    }

    public init(rows: Int, columns: Int, isLoopModeEnabled: Bool) {
        self.rows = rows
        self.columns = columns
        self.world = try! World(columns: columns, rows: rows, mode: isLoopModeEnabled ? .loop : .simple)
        self.gridData = Array(repeating: Array(repeating: false, count: columns), count: rows)
        self.generationCounter = world.generationCounter
    }
}
