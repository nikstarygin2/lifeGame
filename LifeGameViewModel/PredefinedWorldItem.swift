//
//  PredefinedWorldItem.swift
//  LifeGameViewModel


import Foundation

public struct PredefinedWorldsItem: Identifiable {
    public struct PredefinedWorld: Identifiable {
        public let title: String
        public let aliveCellsGenerator: LifeGameAliveCellsGenerator
        public let size: Int
        public var isChecked: Bool
        public let id = UUID()

        public init(
            title: String,
            aliveCellsGenerator: LifeGameAliveCellsGenerator,
            size: Int,
            isChecked: Bool
        ) {
            self.title = title
            self.aliveCellsGenerator = aliveCellsGenerator
            self.size = size
            self.isChecked = isChecked
        }
    }

    public let title: String
    public var worlds: [PredefinedWorld]
    public let id = UUID()

    public init(title: String, worlds: [PredefinedWorld]) {
        self.title = title
        self.worlds = worlds
    }
}
