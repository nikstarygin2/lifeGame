//
//  WorldInitTests.swift
//  LifeGameModelSwiftTestingTests
//
//  Created by Nikita Starygin on 08.07.2024.
//

import Testing

@testable import LifeGameModel

@Test("Test when world init throws error", .tags(.world), arguments: [-1, 0])
func worldInitializationError(size: Int) {
    #expect {
        let _ = try World(columns: size, rows: size)
    } throws: { error in
        guard let error = error as? WorldInitializationErrors, error == .invalidSize else { return false }
        return true
    }
}


