//
//  NetflixHeroCell.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 10.03.2026.
//

import SwiftUI

struct NetflixHeroCell: View {
    
    var imageName: String = Constans.randomImage
    var isNetflixFilm: Bool = true
    var title: String = "Players"
    var categories: [String] = ["Action", "Comedy", "Drama"]
    var onBackgroundTap: (() -> Void)? = nil
    var onPlayTap: (() -> Void)? = nil
    var onMyListTap: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(urlString: imageName)
                
            
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    if isNetflixFilm {
                        HStack(spacing: 8) {
                            Text("N")
                                .foregroundStyle(.netflixRed)
                                .font(.largeTitle)
                                .fontWeight(.black)
                            
                            Text("Film")
                                .foregroundStyle(.netflixWhite)
                                .kerning(3)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Text(title)
                        .font(.system(size: 50, weight: .medium, design: .serif))
                    }
                
                HStack(spacing: 8) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                            .font(.callout)
                        
                        if category != categories.last {
                            Circle()
                                .frame(width: 4, height: 4,)
                        }
                    }
                }
                
                HStack(spacing: 16) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixDarkGray)
                    .background(.netflixWhite)
                    .cornerRadius(6)
                    .onTapGesture {
                        onPlayTap?()
                    }
                    
                    HStack {
                        Image(systemName: "plus")
                        Text("My List")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixWhite)
                    .background(.netflixDarkGray)
                    .cornerRadius(6)
                    .onTapGesture {
                        onMyListTap?()
                    }
                }
                .font(.callout)
                .fontWeight(.medium)
            }
            
            .padding(24)
            .background(
                LinearGradient(
                    colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                            ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
        }
        .foregroundStyle(.netflixWhite)
        .cornerRadius(10)
        .clipped()
        .overlay(                           // ✅ добавь обводку
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        .aspectRatio(0.8, contentMode: .fit)
        .onTapGesture {
            onBackgroundTap?()
        }
    }
}

#Preview {
    NetflixHeroCell()
        .padding(40)
}
