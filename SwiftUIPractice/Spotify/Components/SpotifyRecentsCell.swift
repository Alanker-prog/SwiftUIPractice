//
//  SpotifyRecentsCell.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 03.12.2025.
//

import SwiftUI

struct SpotifyRecentsCell: View {
    
    var imageName: String = Constans.randomImage
    var title: String = "Random title"
    
    var body: some View {
        HStack(spacing:16){
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(1)
        }
            .padding(.trailing, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .themeColots(isSelected: false)
            .cornerRadius(6)
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            HStack {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
            HStack {
                SpotifyRecentsCell()
                SpotifyRecentsCell()
            }
        }
    }
}
