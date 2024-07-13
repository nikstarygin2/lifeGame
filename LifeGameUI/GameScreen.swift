//
//  GameScreen.swift
//  LifeGameUI

import SwiftUI

import LifeGameViewModel
import LifeGameModel

public struct GameScreen: View {
    @State private var viewModel: LifeViewModel
    @State private var isAutoGame: Bool
    @State var rowsCount: Int
    @State var columnsCount: Int
    private let aliveCellsGenerator: LifeGameAliveCellsGenerator

    public init(
        rowsCount:Int,
        columnsCount: Int,
        isAutoGame: Bool,
        aliveCellsGenerator: LifeGameAliveCellsGenerator
    ) {
        self.isAutoGame = isAutoGame
        self.rowsCount = rowsCount
        self.columnsCount = columnsCount
        self.aliveCellsGenerator = aliveCellsGenerator
        self.viewModel = LifeViewModel(
            rows: rowsCount,
            columns: columnsCount
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
                    columns: columnsCount
                )
                aliveCellsGenerator.generate(
                    column: columnsCount,
                    rows: rowsCount
                ) {
                    viewModel.setCells($0)
                    if isAutoGame {
                        viewModel.startGame()
                    }
                }
            },
            columnsCount: columnsCount,
            rowsCount: rowsCount
        ).onAppear {
            aliveCellsGenerator.generate(
                column: columnsCount,
                rows: rowsCount
            ) {
                viewModel.setCells($0)
                if isAutoGame {
                    viewModel.startGame()
                }
            }
        }
    }
}
