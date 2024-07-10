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
            columnsCount: 0,
            rowsCount: 0,
            worldGenerator: LifeGameRandomNumberFetcher(),
            isAutoGame: false,
            predefinedWorlds: [
                PredefinedWorldsItem(
                    title: "Unchanged",
                    worlds: [
                        .init(
                            title: "Block",
                            worldGenerator: Block(),
                            isChecked: true
                        ),
                        .init(
                            title: "Hive",
                            worldGenerator: Hive(),
                            isChecked: false
                        ),
                    ]
                ),
                PredefinedWorldsItem(
                    title: "Oscillators",
                    worlds: [
                        .init(
                            title: "Semaphore",
                            worldGenerator: Semaphore(),
                            isChecked: false
                        ),
                        .init(
                            title: "Pulsar",
                            worldGenerator: Pulsar(),
                            isChecked: false
                        ),
                    ]
                ),
                PredefinedWorldsItem(
                    title: "Endless",
                    worlds: [
                        .init(
                            title: "Glider",
                            worldGenerator: Glider(),
                            isChecked: false
                        ),
                        .init(
                            title: "LWSS",
                            worldGenerator: LWSS(),
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

private struct Block: LifeGameWorldGenerator {
    func generate(column: Int, rows: Int, count: Int, completion: @escaping (Set<Cell>) -> Void) {
        let block: Set<Cell> = [
            .init(row: 1, column: 1),
            .init(row: 1, column: 2),
            .init(row: 2, column: 1),
            .init(row: 2, column: 2)
        ]
        completion(block)
    }
}

private struct Hive: LifeGameWorldGenerator {
    func generate(column: Int, rows: Int, count: Int, completion: @escaping (Set<Cell>) -> Void) {
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

private struct Semaphore: LifeGameWorldGenerator {
    func generate(column: Int, rows: Int, count: Int, completion: @escaping (Set<Cell>) -> Void) {
        let semahpore: Set<Cell> = [
            .init(row: 2, column: 3),
            .init(row: 3, column: 3),
            .init(row: 4, column: 3),
        ]
        completion(semahpore)
    }
}

private struct Pulsar: LifeGameWorldGenerator {
    func generate(column: Int, rows: Int, count: Int, completion: @escaping (Set<Cell>) -> Void) {
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

private struct Glider: LifeGameWorldGenerator {
    func generate(column: Int, rows: Int, count: Int, completion: @escaping (Set<Cell>) -> Void) {
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

private struct LWSS: LifeGameWorldGenerator {
    func generate(column: Int, rows: Int, count: Int, completion: @escaping (Set<Cell>) -> Void) {
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
