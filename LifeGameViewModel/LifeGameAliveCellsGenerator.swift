//
//  LifeGameAliveCellsGenerator.swift
//  LifeGameViewModel

import LifeGameModel

public protocol LifeGameAliveCellsGenerator {
    func generate(
        column: Int,
        rows: Int,
        completion: @escaping (Set<Cell>) -> Void
    )
}
