//
//  GridView.swift
//  LifeGameUI

import SwiftUI

struct GridView: View {
    @Binding private var data: GridData

    init(data: Binding<GridData>) {
        _data = data
    }

    var body: some View {
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
    ]))
}
