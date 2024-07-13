//
//  GridView.swift
//  LifeGameUI

import SwiftUI

struct GridView: View {
    @Binding private var data: GridData?
    private let columnsCount: Int
    private let rowsCount: Int

    init(
        data: Binding<GridData?>,
        columnsCount: Int,
        rowsCount: Int
    ) {
        _data = data
        self.columnsCount = columnsCount
        self.rowsCount = rowsCount
    }

    var body: some View {
        VStack {
            if let data {
                Grid(alignment: .center, horizontalSpacing: 2, verticalSpacing: 2) {
                    ForEach(0..<data.count, id: \.self) { row in
                        GridRow {
                            ForEach(0..<data[row].count, id: \.self) { column in
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(data[row][column] ? .green : .gray)
                                    .shadow(radius: 10)
                            }
                        }
                    }
                }
            } else {
                ZStack {
                    Grid(alignment: .center, horizontalSpacing: 2, verticalSpacing: 2) {
                        ForEach(0..<columnsCount, id: \.self) { _ in
                            GridRow {
                                ForEach(0..<rowsCount, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(.gray)
                                        .shadow(radius: 10)
                                }
                            }
                        }
                    }

                    Color.gray.opacity(0.5)

                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)

                }
            }
        }
        .padding(5)
        .background(.black)
        .frame(width: 300, height: 300)
    }
}

#Preview {
    GridView(data: .constant([
        [true,false, false],
        [false,false,false],
        [false, false, false],
    ]),
             columnsCount: 3,
             rowsCount: 3
    )
}
