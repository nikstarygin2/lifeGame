//
//  SettingsScreen.swift
//  LifeGameUI

import SwiftUI

import LifeGameViewModel
import LifeGameModel

public struct SettingsScreen: View {
    @State private var columnsCount: Int
    @State private var rowsCount: Int
    @State private var isAutoGame: Bool
    @State private var predefinedWorlds: [PredefinedWorldsItem]
    private let aliveCellsGenerator: LifeGameAliveCellsGenerator

    @State private var isGameRunning = false
    @State private var isRandomGame = true

    public init(
        columnsCount: Int,
        rowsCount: Int,
        aliveCellsGenerator: LifeGameAliveCellsGenerator,
        isAutoGame: Bool,
        predefinedWorlds: [PredefinedWorldsItem]
    ) {
        self.columnsCount = columnsCount
        self.rowsCount = rowsCount
        self.isAutoGame = isAutoGame
        self.aliveCellsGenerator = aliveCellsGenerator
        self.predefinedWorlds = predefinedWorlds
    }

    public var body: some View {
        VStack(spacing: 20) {
            Text("Life Game")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.7))
                )

            if isRandomGame {
                Spacer()
            }

            Picker("Game mode", selection: $isRandomGame) {
                Text("Random").tag(true)
                Text("Predefined").tag(false)
            }.pickerStyle(SegmentedPickerStyle())

            if isRandomGame {
                VStack {
                    HStack {
                        Text("Columns")
                            .font(.headline)
                        Spacer()
                        Stepper(value: $columnsCount, in: 0...10) {
                            Text("\(columnsCount)")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(width: 20)
                        }
                        .frame(width: 120)
                    }
                    .settingsBackground()

                    HStack {
                        Text("Rows")
                            .font(.headline)
                        Spacer()
                        Stepper(value: $rowsCount, in: 0...10) {
                            Text("\(rowsCount)")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(width: 20)
                        }
                        .frame(width: 120)
                    }
                    .settingsBackground()
                }
            } else {
                List {
                    ForEach(predefinedWorlds) { predefinedWorld in
                        Section(predefinedWorld.title) {
                            ForEach(predefinedWorld.worlds) { world in
                                HStack {
                                    Text(world.title)
                                    Spacer()
                                    Button(action: {
                                        guard !world.isChecked else { return }
                                        selectItem(world.id)
                                    }) {
                                        Image(systemName: world.isChecked ? "checkmark.square" : "square")
                                            .foregroundColor(world.isChecked ? .green : .gray)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                .listSectionSpacing(0)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }

            VStack {
                HStack {
                    Text("Auto generation")
                        .font(.headline)
                    Spacer()
                    Toggle(isOn: $isAutoGame) {}
                        .labelsHidden()
                }

            }.settingsBackground()


            Button(action: { isGameRunning = true }) {
                Text("Start Game")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isGameRunning) {
            if isRandomGame {
                GameScreen(
                    rowsCount: rowsCount,
                    columnsCount: columnsCount,
                    isAutoGame: isAutoGame,
                    aliveCellsGenerator: aliveCellsGenerator
                )
            } else {
                GameScreen(
                    rowsCount: selectedWorld.size,
                    columnsCount: selectedWorld.size,
                    isAutoGame: isAutoGame,
                    aliveCellsGenerator: selectedWorld.aliveCellsGenerator
                )
            }
        }
    }

    private var selectedWorld: PredefinedWorldsItem.PredefinedWorld {
        predefinedWorlds
            .map(\.worlds)
            .flatMap { $0 }
            .first(where: \.isChecked)!
    }

    private func selectItem(_ id: UUID) {
        for index in predefinedWorlds.indices {
            for worldIndex in predefinedWorlds[index].worlds.indices {
                predefinedWorlds[index].worlds[worldIndex].isChecked = predefinedWorlds[index].worlds[worldIndex].id == id
            }
        }
    }

}


private struct SettingsBackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2)))
    }
}

fileprivate extension View {
    func settingsBackground() -> some View {
        self.modifier(SettingsBackgroundStyle())
    }
}

#Preview {
    SettingsScreen(
        columnsCount: 5,
        rowsCount: 5,
        aliveCellsGenerator: MockLifeGameAliveCellsGenerator(),
        isAutoGame: false,
        predefinedWorlds: []
    )
}

private struct MockLifeGameAliveCellsGenerator: LifeGameAliveCellsGenerator {
    func generate(
        column: Int,
        rows: Int,
        completion: @escaping (Set<LifeGameModel.Cell>) -> Void
    ) {
        var cells: Set<Cell> = Set()
        for _ in 0...(rows * column / 2) {
            cells.insert(
                Cell(
                    row: .random(in: 0..<rows),
                    column: .random(in: 0..<column)
                )
            )
        }
        completion(cells)
    }
}
