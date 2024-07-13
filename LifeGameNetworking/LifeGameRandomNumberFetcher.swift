//
//  LifeGameRandomAliveCellsFetcher.swift
//  LifeGameNetworking

import Combine
import Foundation

import LifeGameViewModel
import LifeGameModel

public final class LifeGameRandomAliveCellsFetcher: LifeGameAliveCellsGenerator {
    private var cancellables = Set<AnyCancellable>()

    public init() {}

    public func generate(column: Int, rows: Int, completion: @escaping (Set<Cell>) -> Void) {
        cancellables.forEach { $0.cancel() }

        let count = (column * rows) / 2
        let columnsPublisher = makeFetcherPublisher(value: column, count: count)
        let rowsPublisher = makeFetcherPublisher(value: rows, count: count)

        rowsPublisher.combineLatest(columnsPublisher)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { columns, rows in
                    var cells = Set<Cell>()
                    for (row, column) in zip(rows, columns) {
                        cells.insert(Cell(row: row, column: column))
                    }
                    completion(cells)
                }
            ).store(in: &cancellables)
    }
}

private func makeFetcherPublisher(value: Int, count: Int) -> AnyPublisher<[Int], Error> {
    let requestURL = randomURL.appending(queryItems: [
        URLQueryItem(name: "min", value: "0"),
        URLQueryItem(name: "max", value: "\(value)"),
        URLQueryItem(name: "count", value: "\(count)"),
    ])

    return URLSession.shared.dataTaskPublisher(for: requestURL)
        .map(\.data)
        .decode(type: [Int].self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

private let randomURL = URL(string: "https://www.randomnumberapi.com/api/v1.0/random")!

