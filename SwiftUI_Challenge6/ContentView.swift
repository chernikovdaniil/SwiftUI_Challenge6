//
//  ContentView.swift
//  SwiftUI_Challenge6
//
//  Created by Danil Chernikov on 16.12.2023.
//

import SwiftUI

#Preview {
    ContentView()
}

struct ContentView: View {
    @State private var applyDiagonalLayout = false
    private let squareCount = 7
    
    var body: some View {
        AnyLayout(GeneralLayout(applyDiagonalLayout: $applyDiagonalLayout)) {
            ForEach(0..<squareCount, id: \.self) { _ in
                Button {
                    withAnimation {
                        applyDiagonalLayout.toggle()
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}
