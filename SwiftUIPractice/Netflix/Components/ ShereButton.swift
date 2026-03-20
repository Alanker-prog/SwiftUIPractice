//
//   ShereButton.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 20.03.2026.
//

import SwiftUI

struct ShereButton: View {
    
    var url: String = "https://www.netflix.com/nl-en/"
    
    @ViewBuilder
    var body: some View {
        if let url = URL(string: url) {
            ShareLink(item: url) {
                VStack(spacing: 8) {
                    Image(systemName: "paperplane")
                
                .font(.title)
                
                Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(.black.opacity(0.001))
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ShereButton()
    }
}
