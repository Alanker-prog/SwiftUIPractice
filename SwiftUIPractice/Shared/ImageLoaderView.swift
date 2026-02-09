//
//  ImageLoaderView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 01.12.2025.
//

import SwiftUI
import SDWebImageSwiftUI

/*
 ✴️ Настраиваем рандомное изображение через пакет SDWebImageSwiftUI(сторонняя библиотека для загрузки изображений из интернета), без ручного URLSession
 
 🔥 Эта стуктура это кастомный SwiftUI-компонент, который можно переиспользовать в других проектах.
 
 🟢 var urlString: String = Constans.randomImage - через urlString вызываем рандомное изображение
 🟢 var resizingMode: ContentMode = .fill - это лкальная перменая делает .aspectRatio(⚠️ключевой модификатор: Rectangle задаёт размер и WebImage растягивается под него) уневерсальным , можно быстро поменять ContentMode: с .fill на .fit ,если стоит другая задача
 
 🟡 Rectangle() тут нужен как подлжка(контейнер) для что бы изображение правильно растинулось обрезалось
    ➡️ .opacity(0.001) - делаем Rectangle() невидимым
    ➡️ через .overlay { накладываем изображение ->  WebImage(url: URL(string: urlString))
    ➡️ .resizable() - что бы можно было менять размер изображения
    ➡️ .indicator(.activity) - индикатор(спинер) загрузки
    ➡️ .allowsHitTesting(false) - выключаем нажатие у изображения(нажимать будем на Rectangle())
    ➡️ .clipped() - обрезаем изображение под размеры  Rectangle(). ⚠️ Но даже после обрезания края фото выходят за рамку Rectangle() но визульно мы этого не видем и на эти края можно нажать и будет ложное нажатие, и именно поэтому мы выключили нажатия у изображения -> .allowsHitTesting(false). И когда пользователь нажмет на изображение, на самом деле он будет нажимать на Rectangle()
 
  ❕Далее создаем DatabaseHelper ➡️
 */
struct ImageLoaderView: View {
    
    var urlString: String = Constans.randomImage
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .padding(40)
        .padding(.vertical, 60)
}
