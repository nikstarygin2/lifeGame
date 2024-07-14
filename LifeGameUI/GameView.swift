//
//  GameView.swift
//  LifeGameUI

import SwiftUI

import LifeGameViewModel

struct GameView: View {
    @Binding private var gridData: GridData?
    @Binding private var isAutoGame: Bool
    @Binding private var generationCounter: Int
    private let nextGenAction: Action
    private let restartAction: Action
    private let columnsCount: Int
    private let rowsCount: Int
    private var isGameOver: Bool {
        guard let gridData else { return false }
        return !gridData
            .flatMap { $0 }
            .reduce(false) { $0 || $1 }
    }

    init(
        gridData: Binding<GridData?>,
        isAutoGame: Binding<Bool>,
        generationCounter: Binding<Int>,
        nextGenAction: @escaping Action,
        restartAction: @escaping Action,
        columnsCount: Int,
        rowsCount: Int
    ) {
        _gridData = gridData
        _isAutoGame = isAutoGame
        _generationCounter = generationCounter
        self.nextGenAction = nextGenAction
        self.restartAction = restartAction
        self.columnsCount = columnsCount
        self.rowsCount = rowsCount
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.lightBlue, .darkBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                VStack {
                    Text("Generation")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("\(generationCounter)")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                Spacer()
                GridView(
                    data: $gridData,
                    columnsCount: columnsCount,
                    rowsCount: rowsCount
                )
                Spacer()
                if !isAutoGame {
                    VStack(spacing: 20) {
                        Button("Next Gen", action: nextGenAction)
                            .lifeGameUIButton(grayBackground: isGameOver)
                            .disabled(gridData == nil)
                    }
                }
                Button("Restart", action: restartAction)
                    .lifeGameUIButton(grayBackground: false)
                Spacer()
            }.padding()
        }
    }
}

private struct GameOverView: View {
    var body: some View {
        Text("Game over")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red.opacity(0.7))
            )
            .padding()
            .transition(.opacity)
    }
}


private struct LifeGameUIStyle: ViewModifier {
    let grayBackground: Bool

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(LinearGradient(
                gradient: Gradient(colors: grayBackground
                                   ? [Color.gray.opacity(0.7), Color.gray]
                                   : [Color.blue, Color.purple]),
                startPoint: .leading,
                endPoint: .trailing)
            )
            .cornerRadius(15)
            .shadow(radius: 10)
    }
}

fileprivate extension View {
    func lifeGameUIButton(grayBackground: Bool) -> some View {
        modifier(LifeGameUIStyle(grayBackground: grayBackground))
    }
}

fileprivate extension Color {
    static let lightBlue = Color(red: 173 / 255, green: 216 / 255, blue: 230 / 255)
    static let darkBlue = Color(red: 0 / 255, green: 0 / 255, blue: 139 / 255)
}

#Preview {
    GameView(
        gridData: .constant([
            [true,false, false],
            [false,false,false],
            [false, false, false],
        ]),
        isAutoGame: .constant(false),
        generationCounter: .constant(10),
        nextGenAction: {},
        restartAction: {},
        columnsCount: 3,
        rowsCount: 3
    )
}
