//
//  LifeGameSnapshotTests.swift
//  LifeGameSnapshotTests
//
//  Created by Nikita Starygin on 08.07.2024.
//

import XCTest

@testable import LifeGameUI

import SnapshotTesting
import LifeGameModel
import LifeGameViewModel

final class LifeGameSnapshotTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        isRecording = false
    }

    func testGameScreen_When5x5Grid() {
        let grid = [(0, 2), (2, 0), (4, 0), (3, 1), (4, 2), (3, 4), (4, 3)]
        let gameScreen = GameScreen(
            rowsCount: 5,
            columnCount: 5,
            isAutoGame: false,
            worldGenerator: LifeGameWorldGeneratorMock(grid: grid),
            isLoopModeEnabled: false
        )

        assertSnapshot(
            of:  gameScreen,
            as: .image(layout: .device(config: .iPhone13)),
            named: "GameScreen_with_5x5_grid"
        )
    }

    func testGameScreen_When10x10Grid() {
        let grid = [
            (3, 7),
            (1, 5),
            (8, 0),
            (4, 4),
            (2, 9),
            (6, 3),
            (7, 1),
            (0, 8),
            (9, 2),
            (5, 6),
            (3, 3),
            (7, 4),
            (1, 0),
            (8, 5),
            (4, 2),
            (2, 7),
            (6, 1),
            (9, 8),
            (0, 6),
            (5, 9),
            (1, 3),
            (4, 7),
            (2, 8),
            (6, 0),
            (7, 5),
        ]
        let gameScreen = GameScreen(
            rowsCount: 10,
            columnCount: 10,
            isAutoGame: false,
            worldGenerator: LifeGameWorldGeneratorMock(grid: grid),
            isLoopModeEnabled: false
        )

        assertSnapshot(
            of: gameScreen,
            as: .image(layout: .device(config: .iPhone13)),
            named: "GameScreen_with_10x10_grid"
        )
    }

    func testGameScreenWith3x3Grid() {
        let grid = [(0, 0), (0, 1), (2, 0), (2, 2)]
        let gameScreen = GameScreen(
            rowsCount: 3,
            columnCount: 3,
            isAutoGame: false,
            worldGenerator: LifeGameWorldGeneratorMock(grid: grid),
            isLoopModeEnabled: false
        )
        assertSnapshot(
            of: gameScreen,
            as: .image(layout: .device(config: .iPhone13)),
            named: "GameScreen_with_3x3_grid"
        )
    }

    func testGameScreen_WhenAutoGameEnabled() {
        let grid = [(0, 1), (1, 0)]

        let gameScreen = GameScreen(
            rowsCount: 3,
            columnCount: 3,
            isAutoGame: true,
            worldGenerator: LifeGameWorldGeneratorMock(grid: grid),
            isLoopModeEnabled: false
        )

        assertSnapshot(
            of: gameScreen,
            as: .image(layout: .device(config: .iPhone13)),
            named: "GameScreen_with_auto_game"
        )
    }
}

private struct LifeGameWorldGeneratorMock: LifeGameWorldGenerator {
    func generate(
        column: Int,
        rows: Int,
        count: Int,
        completion: @escaping (Set<Cell>) -> Void
    ) {
        let cells = Set(grid.map { (x, y) in Cell(row: x, column: y) })
        completion(cells)
    }

    private let grid: [(Int, Int)]

    init(grid: [(Int, Int)]) {
        self.grid = grid
    }
}
