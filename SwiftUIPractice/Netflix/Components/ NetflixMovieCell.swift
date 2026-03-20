//
//   NetflixMovieCell.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 13.03.2026.
//

import SwiftUI

struct NetflixMovieCell: View {
    
    var width: CGFloat = 90
    var height: CGFloat = 140
    var imageName: String = Constans.randomImage
    var title: String? = "Movie title"
    var isRecentlyAdded: Bool = false
    var topTenRanking: Int? = nil
    
    
    
    var body: some View {
        HStack {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: 100, weight: .medium, design: .serif))
                    .offset(x: 12, y: 34)
            }
            
            ZStack(alignment: .bottom) {
                ImageLoaderView(urlString: imageName)
                    
                VStack(spacing: 0) {
                    if let title, let firstWord = title.components(separatedBy: " ").first {
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    
                    
                        Text("Recently Added")
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity)
                            .background(.netflixRed)
                            .cornerRadius(4)
                            .offset(y: 2)
                            .lineLimit(1)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .minimumScaleFactor(0.1)
                            .padding(.horizontal, 8)
                            .opacity(isRecentlyAdded ? 1 : 0)
                    
                    
                }
                .padding(.top, 6)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.3),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4),
                                ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .cornerRadius(3)
            .frame(width: width, height: height)
        }
        .foregroundStyle(.netflixWhite)
        .overlay(                           // ✅ добавь обводку
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            NetflixMovieCell(isRecentlyAdded: true, topTenRanking: 7)
            NetflixMovieCell()
            NetflixMovieCell(isRecentlyAdded: true, topTenRanking: 2)
            NetflixMovieCell()
        }
    }
}
