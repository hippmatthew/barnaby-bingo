//
//  ContentView.swift
//  MidsomerBingo
//
//  Created by Groot on 2/19/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Colors.background
                .ignoresSafeArea()
            
            Image("barnaby")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.6)
                .blur(radius: 5)
            
            VStack(spacing: 10) {
                Header()
                Board()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(10)
        }
    }
}

#Preview {
    ContentView()
}
