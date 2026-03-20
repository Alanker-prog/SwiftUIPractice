//
//  NetflixFileBarView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 05.03.2026.
//

import SwiftUI

struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropdown: Bool
    
    static var mockArrey: [FilterModel] {
     [
         FilterModel(title: "TV Shows", isDropdown: false),
         FilterModel(title: "Movies", isDropdown: false),
         FilterModel(title: "Categories", isDropdown: false),
     ]
    }
}
                        
@MainActor
struct NetflixFileBarView: View {
    
    var filters: [FilterModel] = FilterModel.mockArrey
    var selectedFilter: FilterModel? = nil
    var onFiltreTap: ((FilterModel) -> Void)? = nil
    var onXmarkTap: (() -> Void)? = nil
   
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onXmarkTap?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                
                ForEach(filters, id: \.self) { filter in
                    let isSelected = selectedFilter == filter        // ✅ вычисляем заранее
                    let isVisible = selectedFilter == nil || isSelected
                    
                    if isVisible {
                        NetflixFilterCell(
                            title: filter.title,
                            isDropdown: filter.isDropdown,
                            isSelected: isSelected
                        )
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onFiltreTap?(filter)
                        }
                        .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 16 : 0)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}

@MainActor
fileprivate struct NetflixFileBarViewPrewiew: View {
    
    @State private var filters = FilterModel.mockArrey
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        NetflixFileBarView(
            filters: filters,
            selectedFilter: selectedFilter) { newFilter in
                selectedFilter = newFilter
            } onXmarkTap: {
                selectedFilter = nil 
            }

    }
    
}


#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        NetflixFileBarViewPrewiew()
    }
    
}
