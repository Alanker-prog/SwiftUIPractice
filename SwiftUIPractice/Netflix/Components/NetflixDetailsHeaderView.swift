//
//  NetflixDetailsHeaderView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 18.03.2026.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailsHeaderView: View {
    
    var imageName: String = Constans.randomImage
    var progress: Double = 0.5
    var onAirplayTap: (() -> Void)? = nil
    var onXMarkTap: (() -> Void)? = nil
    
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(urlString: imageName)
            
            CustomProgressBar(
                selection: progress,
                range: 0...1,
                backgroundColor: .netflixLightGray,
                foregroundColor: .netflixRed,
                cornerRadius: 4,
                height: 4
            )
            .padding(.bottom, 4)
            .animation(.linear, value: progress)
            
            HStack(spacing: 8) {
                    Circle()
                        .fill(.netflixDarkGray)
                        .overlay(content: {
                            Image(systemName: "tv.badge.wifi")
                                .offset(x: -0.2 ,y: 1)
                        })
                        .frame(width: 36, height: 36)
                        .onTapGesture {
                            onAirplayTap?()
                        }
                
                Circle()
                    .fill(.netflixDarkGray)
                    .overlay(content: {
                        Image(systemName: "xmark")
                            .offset(y: 1)
                    })
                    .frame(width: 36, height: 36)
                    .onTapGesture {
                       onXMarkTap?()
                    }
                
            }
            .foregroundStyle(.netflixWhite)
            .font(.subheadline)
            .fontWeight(.bold)
            .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(8)
           
            
        }
        .aspectRatio(2, contentMode: .fit)
        
    }
}

#Preview {
    NetflixDetailsHeaderView()
}
