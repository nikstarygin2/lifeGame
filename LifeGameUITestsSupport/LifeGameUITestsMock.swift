//
//  LifeGameUITestsMock.swift
//  LifeGameUITestsSupport
//
//  Created by Nikita Starygin on 08.07.2024.
//

import Foundation

public import LifeGameViewModel
public import LifeGameModel

public final class LifeGameWorldGeneratorUITestsMock: LifeGameWorldGenerator {
    public init() {}

    public func generate(
        column: Int,
        rows: Int,
        count: Int,
        completion: @escaping (Set<Cell>) -> Void) {
            if let boolArray = ProcessInfo.cellForUITests {
                var cells = Set<Cell>()
                for (i, row) in boolArray.enumerated() {
                    for (j, col) in row.enumerated() {
                        if col {
                            cells.insert(Cell(
                                row: i,
                                column: j
                            ))
                        }
                    }
                }
                completion(cells)
            } else {
                completion(Set<Cell>())
            }
        }
}
