//
//  ContentView.swift
//  LifeGame

import SwiftUI

import LifeGameUI
import LifeGameNetworking
import LifeGameViewModel
import LifeGameModel

struct ContentView: View {
    var body: some View {
        SettingsScreen(
            columnsCount: 1,
            rowsCount: 1,
            aliveCellsGenerator: LifeGameRandomAliveCellsFetcher(),
            isAutoGame: false,
            predefinedWorlds: [
                PredefinedWorldsItem(
                    title: "Unchanged",
                    worlds: [
                        .init(
                            title: "Block",
                            aliveCellsGenerator: Block(),
                            size: 5,
                            isChecked: true
                        ),
                        .init(
                            title: "Hive",
                            aliveCellsGenerator: Hive(),
                            size: 8,
                            isChecked: false
                        ),
                    ]
                ),
                PredefinedWorldsItem(
                    title: "Oscillators",
                    worlds: [
                        .init(
                            title: "Semaphore",
                            aliveCellsGenerator: Semaphore(),
                            size: 5,
                            isChecked: false
                        ),
                        .init(
                            title: "Pulsar",
                            aliveCellsGenerator: Pulsar(),
                            size: 18,
                            isChecked: false
                        ),
                    ]
                ),
                PredefinedWorldsItem(
                    title: "Endless",
                    worlds: [
                        .init(
                            title: "Glider",
                            aliveCellsGenerator: Glider(),
                            size: 10,
                            isChecked: false
                        ),
                        .init(
                            title: "LWSS",
                            aliveCellsGenerator: LWSS(),
                            size: 18,
                            isChecked: false
                        ),
                    ]
                )
            ]
        )
    }
}

#Preview {
    ContentView()
}

private struct Block: LifeGameAliveCellsGenerator {
    func generate(column: Int, rows: Int, completion: @escaping (Set<Cell>) -> Void) {
        let block: Set<Cell> = [
            .init(row: 1, column: 1),
            .init(row: 1, column: 2),
            .init(row: 2, column: 1),
            .init(row: 2, column: 2)
        ]
        completion(block)
    }
}

private struct Hive: LifeGameAliveCellsGenerator {
    func generate(column: Int, rows: Int, completion: @escaping (Set<Cell>) -> Void) {
        let hive: Set<Cell> = [
            .init(row: 3, column: 3),
            .init(row: 3, column: 4),
            .init(row: 4, column: 2),
            .init(row: 4, column: 5),
            .init(row: 5, column: 3),
            .init(row: 5, column: 4),
        ]
        completion(hive)
    }
}

private struct Semaphore: LifeGameAliveCellsGenerator {
    func generate(column: Int, rows: Int, completion: @escaping (Set<Cell>) -> Void) {
        let semahpore: Set<Cell> = [
            .init(row: 1, column: 2),
            .init(row: 2, column: 2),
            .init(row: 3, column: 2),
        ]
        completion(semahpore)
    }
}

private struct Pulsar: LifeGameAliveCellsGenerator {
    func generate(column: Int, rows: Int, completion: @escaping (Set<Cell>) -> Void) {
        let pulsar: Set<Cell> = [
            // Верхняя левая группа
            Cell(row: 2, column: 4), Cell(row: 2, column: 5), Cell(row: 2, column: 6),
            Cell(row: 4, column: 2), Cell(row: 4, column: 7),
            Cell(row: 5, column: 2), Cell(row: 5, column: 7),
            Cell(row: 6, column: 2), Cell(row: 6, column: 7),
            Cell(row: 7, column: 4), Cell(row: 7, column: 5), Cell(row: 7, column: 6),

            // Верхняя правая группа
            Cell(row: 2, column: 10), Cell(row: 2, column: 11), Cell(row: 2, column: 12),
            Cell(row: 4, column: 9), Cell(row: 4, column: 14),
            Cell(row: 5, column: 9), Cell(row: 5, column: 14),
            Cell(row: 6, column: 9), Cell(row: 6, column: 14),
            Cell(row: 7, column: 10), Cell(row: 7, column: 11), Cell(row: 7, column: 12),

            // Нижняя левая группа
            Cell(row: 9, column: 4), Cell(row: 9, column: 5), Cell(row: 9, column: 6),
            Cell(row: 10, column: 2), Cell(row: 10, column: 7),
            Cell(row: 11, column: 2), Cell(row: 11, column: 7),
            Cell(row: 12, column: 2), Cell(row: 12, column: 7),
            Cell(row: 14, column: 4), Cell(row: 14, column: 5), Cell(row: 14, column: 6),

            // Нижняя правая группа
            Cell(row: 9, column: 10), Cell(row: 9, column: 11), Cell(row: 9, column: 12),
            Cell(row: 10, column: 9), Cell(row: 10, column: 14),
            Cell(row: 11, column: 9), Cell(row: 11, column: 14),
            Cell(row: 12, column: 9), Cell(row: 12, column: 14),
            Cell(row: 14, column: 10), Cell(row: 14, column: 11), Cell(row: 14, column: 12)
        ]

        completion(pulsar)
    }
}

private struct Glider: LifeGameAliveCellsGenerator {
    func generate(column: Int, rows: Int, completion: @escaping (Set<Cell>) -> Void) {
        let glider: Set<Cell> = [
            .init(row: 1, column: 0),
            .init(row: 2, column: 1),
            .init(row: 0, column: 2),
            .init(row: 1, column: 2),
            .init(row: 2, column: 2),
        ]
        completion(glider)
    }
}

private struct LWSS: LifeGameAliveCellsGenerator {
    func generate(column: Int, rows: Int, completion: @escaping (Set<Cell>) -> Void) {
        let lwss: Set<Cell> = [
            Cell(row: 6, column: 7),
            Cell(row: 6, column: 10),
            Cell(row: 7, column: 6),
            Cell(row: 8, column: 6),
            Cell(row: 8, column: 10),
            Cell(row: 9, column: 6),
            Cell(row: 9, column: 7),
            Cell(row: 9, column: 8),
            Cell(row: 9, column: 9)
        ]


        completion(lwss)
    }
}
