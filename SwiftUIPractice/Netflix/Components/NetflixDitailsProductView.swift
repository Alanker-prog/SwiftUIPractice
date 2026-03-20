//
//  NetflixDitailsProductView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 18.03.2026.
//

import SwiftUI

struct NetflixDitailsProductView: View {
    
    var title: String = "Movie Title"
    var isNew: Bool = true
    var yearReleased: String? = "2026"
    var seasonCount: Int? = 4
    var hasClosedCaptions: Bool = true
    var isTopTen: Int? = 7
    var descriptionText: String? = "This is description text for the title for selected fnd it should go multiple lines"
    var castText: String? = "Cast: Alan, unknown film Netflix"
    var onPlayTap: (() -> Void)? = nil
    var onDownloadTap: (() -> Void)? = nil

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                if isNew {
                    Text("New")
                        .font(.title2)
                        .foregroundStyle(.green)
                }
                
                if let yearReleased {
                    Text(yearReleased)
                }
                
                if let seasonCount {
                    Text("\(seasonCount) \(seasonCount == 1 ? "Season" : "Seasons")")
                }
                
                if hasClosedCaptions {
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGray)
            
            if let isTopTen {
                HStack(spacing: 8) {
                    topTenIcon
                    
                    Text("#\(isTopTen) in TV Shows Today")
                        .font(.headline)
                }
            }
            
            VStack(spacing: 8) {
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
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixWhite)
                .background(.netflixDarkGray)
                .cornerRadius(6)
                .onTapGesture {
                    onDownloadTap?()
                }
            }
            
            Group {
                if let descriptionText {
                    Text(descriptionText)
                }
                
                if let castText {
                    Text(castText)
                        .foregroundStyle(.netflixLightGray)
                }
                    
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        }
        .foregroundStyle(.netflixWhite)
    }
    
    private var topTenIcon: some View {
        Rectangle()
            .fill(.netflixRed)
            .frame(width: 30, height: 30)
            .overlay {
                VStack(alignment: .center) {
                    Text("Top")
                        .font(.system(size: 8, weight: .bold))
                    Text("10")
                        .font(.system(size: 14, weight: .bold))
                }
            }
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        VStack(spacing: 40) {
            NetflixDitailsProductView()
            NetflixDitailsProductView(
                isNew: false,
                hasClosedCaptions: false,
                isTopTen: nil,
                descriptionText: nil,
                castText: nil,
                
            )
        }
    }
}
