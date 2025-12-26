//
//  ImageTitleRowCell.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 05.12.2025.
//

import SwiftUI

/*
 🟢 var imageSize: CGFloat = 100
   ➡️ Мы задем жеский размер для горизонтального скролла что бы каждая ячейка заранее знала свой размер, это ускорит работу приложения (Если не задать размер жестко каждая ячейка будет высчитывать свой размер пи каждой отресовке)
   ➡️ Фиксированный imageSize даёт: Ровную сетку, одинаковую высоту всех ячеек,  UI быстрее отресоввывается без задержек
 
 🟢 Зачем дублируется .frame(width: imageSize) у VStack
    🟡 Это важно, потому что:
        ➡️ ширина текста подгоняется под ширину изображения
        ➡️ текст не растягивает карточку
        ➡️ вся ячейка становится квадратной по ширине
    🟡 Без этого:
        ➡️ длинный Text может растянуть ячейку
        ➡️ layout в ScrollView(.horizontal) «поедет»
 */
struct ImageTitleRowCell: View {
    
    var imageSize: CGFloat = 100
    var imageName: String = Constans.randomImage
    var title: String = "Some title name"
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .lineLimit(1)
                .padding( 8)
                
        }
        .frame(width: imageSize)
        .themeColots(isSelected: false)
        .cornerRadius(10)
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ImageTitleRowCell()
    }
   
}
