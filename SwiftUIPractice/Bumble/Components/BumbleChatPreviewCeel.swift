//
//  BumbleChatPreviewCeel.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 23.01.2026.
//

import SwiftUI

struct BumbleChatPreviewCeel: View {
    
    var imageName: String = Constans.randomImage
    var percentegeRemaining: Double = Double.random(in: 0...1)
    var hasNewMassege: Bool = true
    var userName: String = "Alan"
    var lastChatMessage: String? = "This is last messagehsfbwfbiswfbhskfhkshfbshf"
    var isYourMove: Bool = true
    
    
    var body: some View {
        HStack(spacing: 12) {
            BumbleProfileImageCell()
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(userName)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                   
                    if isYourMove {
                        Text("Your Move")
                            .font(.caption)
                            .bold()
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(.bumbleYellow)
                            .cornerRadius(10)
                    }
                }
                
                if let lastChatMessage {
                    Text(lastChatMessage)
                        .font(.subheadline)
                        .foregroundColor(.bumbleGray)
                        .padding(.trailing, 15)
                }
            }
            .lineLimit(1)
        }
    }
}
#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack{
            BumbleChatPreviewCeel()
                .padding()
        }
        
    }
    
}

    

