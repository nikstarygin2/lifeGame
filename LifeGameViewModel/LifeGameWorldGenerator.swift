//
//  LifeGameWorldGenerator.swift
//  LifeGameViewModel

import LifeGameModel

public protocol LifeGameWorldGenerator {
    func generate(
        column: Int,
        rows: Int,
        count: Int,
        completion: @escaping (Set<Cell>) -> Void
    )
}
