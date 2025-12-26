//
//  SpotifyNewReleaseCell.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 03.12.2025.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    
    var imageName: String = Constans.randomImage
    var hedline: String? = "New Release"
    var subhedline: String? = "Some Artist"
    var title: String? = "Some Playlist"
    var subtitle: String? = "Single-title"
    var onAddToPlaylistPressed : (() -> Void)? = nil
    var onPlayPressed : (() -> Void)? = nil

    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                
                VStack(alignment: .leading, spacing: 2) {
                    if let hedline {
                        Text(hedline)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.callout)
                    }
                    
                    if let subhedline {
                        Text(subhedline)
                            .foregroundStyle(.spotifyWhite)
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack() {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)
                
                
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 3) {
                        if let title {
                            Text(title)
                                .foregroundStyle(.spotifyWhite)
                                .font(.title2)
                                .fontWeight(.medium)
                                .lineLimit(1)
                            
                            if let subtitle {
                                Text(subtitle)
                                    .foregroundStyle(.spotifyLightGray)
                                    .font(.caption)
                                    .lineLimit(2)
                            }
                        }
                        
                        HStack(spacing: 0) {
                            Image(systemName: "plus.circle")
                                .foregroundStyle(.spotifyLightGray)
                                .font(.title3)
                                .padding(4)
                                .background(Color.black.opacity(0.001))
                                .onTapGesture {
                                    onAddToPlaylistPressed?()
                                }
                                .offset(y: 9)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                            Image(systemName: "play.circle.fill")
                                .foregroundStyle(.spotifyWhite)
                                .font(.title)
                                .offset(y: 6)
                                
                        }
                        .padding(.top, 20)
                        
                    }
                    .padding(.leading, 8)
                    
                }
                .padding(.trailing, 15)
                
            }
            .themeColots(isSelected: false)
            .cornerRadius(12)
            .onTapGesture {
                onPlayPressed?()
            }
            
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SpotifyNewReleaseCell()
            .padding()
    }
}
