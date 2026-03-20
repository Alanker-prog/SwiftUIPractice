//
//  MyListButton.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 19.03.2026.
//

import SwiftUI

struct MyListButton: View {
    
    var isMyList: Bool = false
    var onButtonTap: (() -> Void)? = nil
    
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Image(systemName: "plus")
                    .opacity(isMyList ? 0 : 1)
                    .rotationEffect(Angle(degrees: isMyList ? -180 : 0))
                
                Image(systemName: "checkmark")
                    .opacity(isMyList ? 1 : 0)
                    .rotationEffect(Angle(degrees: isMyList ? 0 : 180))
            }
            .font(.title)
            
            Text("My List")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.black.opacity(0.001))
        .animation(.bouncy, value: isMyList)
        .onTapGesture {
            onButtonTap?()
        }
    }
}

    fileprivate struct MyListButtonPreview: View {
        
        @State private var isMyList: Bool = false
        
        var body: some View {
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
        }
    }
    
    #Preview {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            MyListButtonPreview()
        }
    }

