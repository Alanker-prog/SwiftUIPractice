//
//  PlaylistHeaderCell.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 07.12.2025.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {
    
    var heigth: CGFloat = 300
    var title: String = "Some playlist title"
    var subtitle: String = "Some subtitle"
    var imageName: String = Constans.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.2)
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                ImageLoaderView(urlString: imageName)
            }
                .overlay(
                    VStack(alignment: .leading, spacing: 12) {
                        Text(subtitle)
                            .font(.headline)
                            .shadow(radius: 0.8)
                        Text(title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .shadow(radius: 0.8)
                    }
                        .foregroundStyle(.spotifyWhite)
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            LinearGradient(colors: [shadowColor.opacity(0), shadowColor], startPoint: .top, endPoint: .bottom)
                        )
                    , alignment: .bottomLeading
                )
                // Растягивает заголовок(готовый модификатор в SwiftfulUI)
                .asStretchyHeader(startingHeight: heigth)
                
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}
