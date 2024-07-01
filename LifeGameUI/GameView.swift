//
//  GameView.swift
//  LifeGameUI

import SwiftUI

internal import LifeGameViewModel

struct GameView: View {
    @Binding private var gridData: GridData
    @Binding private var isAutoGame: Bool
    private let nextGenAction: Action
    private let restartAction: Action

    init(
        gridData: Binding<GridData>,
        isAutoGame: Binding<Bool>,
        nextGenAction: @escaping Action,
        restartAction: @escaping Action
    ) {
        _gridData = gridData
        _isAutoGame = isAutoGame
        self.nextGenAction = nextGenAction
        self.restartAction = restartAction
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.lightBlue, .darkBlue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                Spacer()
                GridView(data: $gridData)
                Spacer()
                if !isAutoGame {
                    VStack(spacing: 20) {
                        Button("Next Gen", action: nextGenAction)
                            .lifeGameUIButton()
                    }
                }
                Button("Restart", action: restartAction)
                    .lifeGameUIButton()
                Spacer()
            }.padding()
        }
    }
}

private struct GameOverView: View {
    var body: some View {
        Text("Game over")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red.opacity(0.7))
            )
            .padding()
            .transition(.opacity)
    }
}


private struct LifeGameUIStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 50)
            .background(LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .leading,
                endPoint: .trailing)
            )
            .cornerRadius(15)
            .shadow(radius: 10)
    }
}

fileprivate extension View {
    func lifeGameUIButton() -> some View {
        modifier(LifeGameUIStyle())
    }
}

fileprivate extension Color {
    static let lightBlue = Color(red: 173 / 255, green: 216 / 255, blue: 230 / 255)
    static let darkBlue = Color(red: 0 / 255, green: 0 / 255, blue: 139 / 255)
}

#Preview {
    GameView(
        gridData: .constant([
            [true,false, false],
            [false,false,false],
            [false, false, false],
        ]),
        isAutoGame: .constant(false),
        nextGenAction: {},
        restartAction: {}
    )
}
