//
//  PredefinedWorldItem.swift
//  LifeGameViewModel


import Foundation

public struct PredefinedWorldsItem: Identifiable {
    public struct PredefinedWorld: Identifiable {
        public let title: String
        public let worldGenerator: LifeGameWorldGenerator
        public var isChecked: Bool
        public let id = UUID()

        public init(title: String, worldGenerator: LifeGameWorldGenerator, isChecked: Bool) {
            self.title = title
            self.worldGenerator = worldGenerator
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
