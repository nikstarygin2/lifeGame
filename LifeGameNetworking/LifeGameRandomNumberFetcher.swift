//
//  LifeGameRandomNumberFetcher.swift
//  LifeGameNetworking

import Combine
import Foundation

import LifeGameViewModel
import LifeGameModel

public final class LifeGameRandomNumberFetcher: LifeGameWorldGenerator {
    private var cancellables = Set<AnyCancellable>()

    public init() {}

    public func generate(column: Int, rows: Int, count: Int, completion: @escaping (Set<Cell>) -> Void) {
        let columnRequestURL = randomURL.appending(queryItems: [
            URLQueryItem(name: "min", value: "0"),
            URLQueryItem(name: "max", value: "\(column)"),
            URLQueryItem(name: "count", value: "\(count)"),
        ])
        let rowsRequestURL = randomURL.appending(queryItems: [
            URLQueryItem(name: "min", value: "0"),
            URLQueryItem(name: "max", value: "\(rows)"),
            URLQueryItem(name: "count", value: "\(count)"),
        ])

        let columnPublisher = URLSession.shared.dataTaskPublisher(for: columnRequestURL)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()

        let rowsPublisher = URLSession.shared.dataTaskPublisher(for: rowsRequestURL)
            .map(\.data)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()

        columnPublisher.combineLatest(rowsPublisher)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { columns, rows in
                    var cells = Set<Cell>()
                    for point in zip(columns, rows) {
                        cells.insert(Cell(row: point.0, column: point.1))
                    }
                    DispatchQueue.main.async {
                        completion(cells)
                    }
                }
            ).store(in: &cancellables)
    }
}

private let randomURL = URL(string: "https://www.randomnumberapi.com/api/v1.0/random")!

