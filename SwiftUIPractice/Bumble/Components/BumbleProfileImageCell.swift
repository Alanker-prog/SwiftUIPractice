//
//  BumbleProfileImageCell.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 23.01.2026.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    
    var imageName: String = Constans.randomImage
    var percentegeRemaining: Double = Double.random(in: 0...1)
    var hasNewMassege: Bool = true
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.bumbleGray, lineWidth: 2)
            
            Circle()
                .trim(from: 0, to: percentegeRemaining)
                .rotation(Angle(degrees: -90))
                .stroke(.bumbleYellow, lineWidth: 4)
                .scaleEffect(x: -1, y: 1, anchor: .center)
            
            ImageLoaderView(urlString: imageName)
                .clipShape(.circle)
                .padding(5)
        }
        .frame(width: 75, height: 75)
        .overlay(alignment: .bottomTrailing) {
            ZStack {
                if hasNewMassege {
                    Circle()
                        .fill(.bumbleWhite)
                        
                    Circle()
                        .fill(.bumbleYellow)
                        .padding(3)
                }
            }
            .frame(width: 20, height: 20)
            .offset(x: -2, y: -2)
        }
        
        
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack{
            BumbleProfileImageCell()
            BumbleProfileImageCell( percentegeRemaining: 0.1, hasNewMassege: false)
            BumbleProfileImageCell( percentegeRemaining: 0.5, hasNewMassege: false)
            BumbleProfileImageCell()
        }
        
    }
    
}
