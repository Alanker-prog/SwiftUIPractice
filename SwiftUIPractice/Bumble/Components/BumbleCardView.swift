//
//  BumbleCardView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 14.01.2026.
//

import SwiftUI
import SwiftfulUI

struct BumbleCardView: View {
    
    var user: User = .mock
    var onSuperLikeTap: (() -> Void)? = nil
    var onXmarkTap: (() -> Void)? = nil
    var onCheckmarkTap: (() -> Void)? = nil
    var onSendComplimentTap: (() -> Void)? = nil
    var onHideAndReportTap: (() -> Void)? = nil
   
    @State var cardFrame: CGRect = .zero
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                headerCell
                    .frame(height: cardFrame.height)
                
                aboutMeSection
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
                
                myInterestSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                
                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                }
                .frame(height: cardFrame.height)
                
                
                locationSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                
                footerSection
                    .padding(.top, 40)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
            
                
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(alignment: .bottomTrailing) {
            superLikeButton
                .padding(20)
        }
        .cornerRadius(32)
        .readingFrame { frame in
            cardFrame = frame
        }
    }
    
    
    
    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundColor(.bumbleGray)
    }
    
    private var superLikeButton: some View {
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.bumbleYellow)
            .font(Font.system(size: 60, weight: .thin))
            .overlay {
                Image(systemName: "star.fill")
                    .foregroundStyle(.bumbleBlack)
                    .font(.title3)
            }
            .onTapGesture {
                onSuperLikeTap?()
            }
    }
    
    private var headerCell: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView(urlString: user.image)
                
            VStack(alignment: .leading, spacing: 5) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack {
                    Image(systemName: "suitcase")
                    Text(user.work)
                }
                
                HStack {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }
                
                BumbleHeartView()
                    .onTapGesture {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .background(
                LinearGradient(
                    colors: [
                        .bumbleBlack.opacity(0),
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }

    
    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
           sectionTitle(title: "About Me")
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            
            HStack(spacing: 0){
                BumbleHeartView()
                
                Text("Send a Compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding([.horizontal, .trailing], 8)
            .background(.bumbleYellow)
            .clipShape(.capsule)
            .onTapGesture {
                onSendComplimentTap?()
            }
           
          
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var myInterestSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My basics")
                InterestPillGreedView(interests: user.basics)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My interests")
                InterestPillGreedView(interests: user.interests)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "`s Location")
            }
            .font(.body)
            .fontWeight(.light)
            
            Text("10 miles away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            InterestPillView(iconName: nil, emoji: "🇷🇺", text: "Lives in Saint Petersburg")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var footerSection: some View {
        VStack( spacing: 24) {
            HStack {
                Circle()
                    .foregroundStyle(.bumbleYellow)
                    .frame(width: 60, height: 60)
                    .overlay {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .onTapGesture {
                        onXmarkTap?()
                    }
                
                Spacer(minLength: 0)
                
                Circle()
                    .foregroundStyle(.bumbleYellow)
                    .frame(width: 60, height: 60)
                    .overlay {
                        Image(systemName: "checkmark")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .onTapGesture {
                        onCheckmarkTap?()
                    }
            }
            
            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    onHideAndReportTap?()
                }
        }
        
    }
}


#Preview {
    BumbleCardView()
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
}
