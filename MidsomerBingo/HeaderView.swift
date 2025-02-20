//
//  HeaderView.swift
//  MidsomerBingo
//
//  Created by Groot on 2/19/25.
//

import SwiftUI

struct Header : View {
    private let brightness = 0.75
    
    var body: some View {
        VStack {
            Text("midsomer")
                .padding(.bottom, 1)
                .font(.custom("SnellRoundhand", size: 23))
                .kerning(6)
                .foregroundColor(Colors.textLight)
                .brightness(brightness)
                .bold()
            
            HStack(spacing: 0) {
                ForEach(Array("BINGO"), id: \.self) { c in
                    Text(String(c))
                        .font(.custom("MarkerFelt-Wide", size: 40))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Colors.textLight)
                        .brightness(brightness)
                        .bold()
                }
            }
            .padding(.bottom, 7)
            
            Divider()
                .frame(height: 1)
                .background(Colors.textLight)
                .brightness(brightness)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
        }
    }
}

#Preview {
    Header()
        .padding(5)
        .background(Color.black)
}
