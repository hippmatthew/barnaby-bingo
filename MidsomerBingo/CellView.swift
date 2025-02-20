//
//  CellView.swift
//  MidsomerBingo
//
//  Created by Groot on 2/19/25.
//

import SwiftUI

struct Cell : View {
    let text : String
    let size : CGFloat
    
    @State private var isSelected = false
    
    var body : some View {
        Text(text)
            .padding(3)
            .font(.system(.body, design: .monospaced))
            .frame(width: size, height: size, alignment: .center)
            .background(isSelected ? Colors.secondary : Colors.primary)
            .cornerRadius(8.0)
            .shadow(color: Colors.shadow.opacity(0.5), radius: 4, x: 0, y: 4)
            .foregroundColor(isSelected ? Colors.tertiary : Colors.text)
            .minimumScaleFactor(0.3)
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .animation(.easeOut(duration: 0.25), value: isSelected)
            .onTapGesture {
                isSelected.toggle()
            }
    }
}

#Preview {
    Cell(text: "Hello World", size: 300.0)
}
