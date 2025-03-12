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
    
    var body : some View {
        Group {
            if cells.isEmpty {
                Text(err != nil ? "Loading board..." : "\(String(describing: err))")
            }
            else {
                GeometryReader { geometry in
                    let sideLength = (geometry.size.width - 10) / 5
                    let spacing = (geometry.size.height - sideLength * 5) / 4
                    let columns = Array(repeating: GridItem(.flexible()), count: 5)
                    let offset = -geometry.size.height / 2;
                    
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(cells, id: \.self) { cell in
                            Cell(text: cell, size: sideLength)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .onAppear {
            getBoard()
        }
    }
    
    func getBoard() {
        guard let sources = NSDataAsset(name: "sources") else {
            err = "bingo file not found"
            return
        }
        
        do {
            let file = try parse(sources.data)
            cells = Array(file.items.shuffled().prefix(25)).map { $0.lowercased() }
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
