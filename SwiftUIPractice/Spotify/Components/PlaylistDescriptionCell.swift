//
//  PlaylistDescriptionCell.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 08.12.2025.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    
    /*
     🟢 var onAddToPlaylistPressd: (() -> Void)? = nil
        ➡️ Удобно переиспользовать и преназначать логика живет в этой ячейке, а оснойной View чистый
        ⚠️ В продакшен лучше делать имена короче -> let onDownload: (() -> Void)? = nil
        ❌ Также лучше использовать let ,но тогда придется вручную писать инит. (У var есть атоинит и это делает написание кода быстрее)
     🔥 Иногда могут попросить объеденить все эти к нопки в одну структуру (struct Actions), так архитиктурно правильней!
     */
    var descriptionText: String = Product.mock.description
    var userName: String = "Alan"
    var subhedline: String = "Some hedline goes here"
    var onAddToPlaylistPressd: (() -> Void)? = nil
    var onDownloadPressd: (() -> Void)? = nil
    var onSharePressd: (() -> Void)? = nil
    var onEllipsisPressd: (() -> Void)? = nil
    var onShufflePressd: (() -> Void)? = nil
    var onPlayPressd: (() -> Void)? = nil
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(descriptionText)
                .foregroundStyle(.spotifyLightGray)
            
            madeForYouSection
            
            Text(subhedline)
                .foregroundStyle(.spotifyLightGray)
            
            buttonsRow
            
            
        }
        .padding()
        .font(.callout)
        .foregroundStyle(.spotifyWhite)
        
    }
    
    private var madeForYouSection: some View {
        
        HStack( spacing: 8) {
            Image(systemName: "apple.logo")
                .font(.title3)
                .foregroundStyle(.spotifyGreen)
            
            Text("Made for")
            
            Text(userName)
                .bold()
        }
    }
    
    private var buttonsRow: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "ellipsis.circle")
                    .padding(8)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 46))
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .foregroundStyle(.spotifyGreen)
        }
        .font(.title3)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlaylistDescriptionCell()
    }
}
