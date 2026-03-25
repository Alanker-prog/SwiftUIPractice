//
//  NetflixHomeView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 04.03.2026.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct NetflixHomeView: View {
    
    @Environment(\.router) var router
    @StateObject private var viewModel = NetflixHomeViewModel()
    
    @State private var fullHeaderSize: CGSize = .zero
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            backgroundGradientLayer
            scrollViewLayer
            fullHeaderWithFilter
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await viewModel.getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    // MARK: Layers
    
    private var backgroundGradientLayer: some View {
        ZStack {
            LinearGradient(
                colors: [.netflixDarkGray.opacity(1), .netflixDarkGray.opacity(0)],
                startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            LinearGradient(
                colors: [.netflixDarkRed.opacity(1), .netflixDarkRed.opacity(0)],
                startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, 400 + scrollViewOffset * 0.75))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    private var scrollViewLayer: some View {
        ScrollViewWithOnScrollChanged(.vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                Rectangle()
                    .opacity(0)
                    .frame(height: fullHeaderSize.height)
                
                if let heroProduct = viewModel.heroProduct {
                    heroCell(product: heroProduct)
                }
                
                categoryRows
            }
        } onScrollChanged: { offset in
            scrollViewOffset = min(0, offset.y)
        }
    }
    
    private var fullHeaderWithFilter: some View {
        VStack(spacing: 0) {
            header
                .padding(.horizontal, 16)
            
            if scrollViewOffset > -25 {
                NetflixFileBarView(
                    filters: viewModel.filters,
                    selectedFilter: viewModel.selectedFilter
                ) { newFilter in
                    viewModel.selectFilter(newFilter)
                } onXmarkTap: {
                    viewModel.clearFilter()
                }
                .padding(.top, 16)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            ZStack {
                if scrollViewOffset < -65 {
                    Rectangle()
                        .fill(.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
            }
        }
    }
    
    // MARK: Cells
    
    private var header: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                Image(systemName: "magnifyingglass")
            }
        }
        .font(.title2)
    }
    
    private func heroCell(product: Product) -> some View {
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            categories: viewModel.categories(for: product)
        ) {
            onProductPressed(product: product)
        } onPlayTap: {
            onProductPressed(product: product)
        } onMyListTap: {
            
        }
        .padding(24)
    }
    
    private var categoryRows: some View {
        LazyVStack(spacing: 16) {
            ForEach(Array(viewModel.productRow.enumerated()), id: \.offset) { rowIndex, row in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row.title)
                        .font(.headline)
                        .padding(.leading, 16)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id: \.offset) { index, product in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTenRanking: rowIndex == 1 ? index + 1 : nil
                                )
                                .onTapGesture {
                                    onProductPressed(product: product)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
    // MARK: Actions
    
    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMovieDetailsView(product: product)
        }
    }
}

// MARK: Preview

#Preview {
    RouterView { _ in
        NetflixHomeView()
    }
}
