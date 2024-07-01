//
//  GameScreen.swift
//  LifeGameUI

import SwiftUI

public import LifeGameViewModel
import LifeGameModel

public struct GameScreen: View {
    @State private var viewModel: LifeViewModel
    @State private var isAutoGame: Bool
    @State var rowsCount: Int
    @State var columnCount: Int
    private let worldGenerator: LifeGameWorldGenerator

    public init(
        rowsCount:Int,
        columnCount: Int,
        isAutoGame: Bool,
        worldGenerator: LifeGameWorldGenerator
    ) {
        self.isAutoGame = isAutoGame
        self.rowsCount = rowsCount
        self.columnCount = columnCount
        self.worldGenerator = worldGenerator
        self.viewModel = LifeViewModel(
            rows: rowsCount,
            columns: columnCount
        )
    }

    public var body: some View {
        GameView(
            gridData: $viewModel.gridData,
            isAutoGame: $isAutoGame,
            nextGenAction: viewModel.nextGen,
            restartAction: {
                viewModel = LifeViewModel(
                    rows: rowsCount,
                    columns: columnCount
                )
                worldGenerator.generate(
                    column: columnCount,
                    rows: rowsCount,
                    count: columnCount * rowsCount / 2
                ) {
                    viewModel.setCells($0)
                    if isAutoGame {
                        viewModel.startGame()
                    }
                }
            }
        ).onAppear {
            worldGenerator.generate(
                column: columnCount,
                rows: rowsCount,
                count: columnCount * rowsCount / 2
            ) {
                viewModel.setCells($0)
                if isAutoGame {
                    viewModel.startGame()
                }
            }
        }
    }
}
