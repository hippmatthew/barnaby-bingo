//
//  BoardView.swift
//  MidsomerBingo
//
//  Created by Groot on 2/19/25.
//

import SwiftUI

struct Board : View {
    @State private var cells : [String] = []
    @State private var err : String? = nil
    
    let items = Array(1...25).map { "Item \($0)" }
    
    var body : some View {
        Group {
            if err != nil {
                Text("failed to load board with error: \(String(describing: err))")
                    .bold()
            }
            else if cells.isEmpty {
                Text("loading board...")
            }
            else {
                GeometryReader { geometry in
                    let sideLength = (geometry.size.width - 10) / 5
                    let spacing = (geometry.size.height - sideLength * 5) / 4
                    let columns = Array(repeating: GridItem(.flexible()), count: 5)
                    
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(cells, id: \.self) {cell in
                            Cell(text: cell, size: sideLength)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .onAppear(perform: getBoard)
    }
    
    func getBoard() {
        guard let filepath = Bundle.main.url(forResource: "sources", withExtension: "bingo") else {
            err = "failed to find bingo file"
            return
        }
        
        do {
            let file = try parse(url: filepath)
            cells = Array(file.items.shuffled().prefix(25))
            cells[12] = "free"
        }
        catch {
            err = "\(error)"
        }
    }
}

#Preview {
    Board()
}
