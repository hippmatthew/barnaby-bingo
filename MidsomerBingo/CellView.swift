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
    @State private var generator = UIImpactFeedbackGenerator(style: .light)
    
    var body : some View {
        Text(text)
            .padding(3)
            .font(.system(.body, design: .monospaced))
            .foregroundColor(isSelected ? Colors.tertiary : Colors.textDark)
            .saturation(isSelected ? 0.6 : 1.0)
            .frame(width: size, height: size, alignment: .center)
            .background(isSelected ? Colors.secondary : Colors.primary)
            .cornerRadius(8.0)
            .shadow(color: Colors.shadow.opacity(0.5), radius: 4, x: 0, y: 4)
            .minimumScaleFactor(0.3)
            .lineLimit(nil)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .animation(.easeOut(duration: 0.225), value: isSelected)
            .onTapGesture {
                isSelected.toggle()
                generator.prepare()
                generator.impactOccurred()
            }
    }
}

#Preview {
    Cell(text: "Hello World", size: 300.0)
}
