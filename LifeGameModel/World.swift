//
//  World.swift
//  LifeGameModel

import Foundation

public final class World {
    private let rows: Int
    private let columns: Int
    public private(set) var aliveCells: Set<Cell> = []

    public init(
        columns: Int,
        rows: Int
    ) {
        self.columns = columns
        self.rows = rows
    }

    // Метод для добавления живых клеток в "мир"
    public func add(_ cells: Set<Cell>) {
        aliveCells.formUnion(cells.filter(isWorldContainCell))
    }

    public func nextGeneration() {
        var cellsWithNeighbours = calculateCellsWithAliveNeighbours()
        // Создаем новый пустой набор клеток
        var newCells: Set<Cell> = []

        // если у клетки есть две или три живые соседки, то эта клетка продолжает жить
        // добавляем найденную клетку в новый набор
        for cell in aliveCells {
            if let count = cellsWithNeighbours.removeValue(forKey: cell), (count == 2 || count == 3) {
                newCells.insert(cell)
            }
        }

        // в пустой (мёртвой) клетке, с которой соседствуют три живые клетки, зарождается жизнь;
        // добавляем найденную клетку в новый набор
        for (cell, count) in cellsWithNeighbours {
            guard count == 3 else { continue }
            newCells.insert(cell)
        }

        // в противном случае (если живых соседей меньше двух или больше трёх)
        // клетка умирает («от одиночества» или «от перенаселённости»).

        aliveCells = newCells
    }
    
    // Метод для нахождения возможных соседних клеток для заданной клетки
    func calculateNeighbours(for cell: Cell) -> Set<Cell> {
        Set(cell.neighbours().filter(isWorldContainCell))
    }
    
    // Метод вычисления словаря клеток,
    // у которых есть хотя бы одна соседняя живая клетка
    // ключ - клетка, значение - количество живых соседних клеток
    private func calculateCellsWithAliveNeighbours() -> [Cell: Int] {
        var dict: [Cell: Int] = [:]

        for cell in aliveCells {
            for neighbour in calculateNeighbours(for: cell) {
                dict[neighbour, default: 0] += 1
            }
        }

        return dict
    }

    private func isWorldContainCell(_ cell: Cell) -> Bool {
        (cell.row >= 0 && cell.row < rows) && (cell.column >= 0 && cell.column < columns)
    }
}
