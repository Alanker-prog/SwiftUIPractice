//
//  BumbleFilterView.swift
//  SwiftUIPractice
//
//  Created by Алан Парастаев on 13.01.2026.
//

import SwiftUI

struct BumbleFilterView: View {
    
    var options: [String] = ["Everyone", "Trending"]
    @Binding  var selection: String
    @Namespace private var namespase
    
    var body: some View {
        
            HStack(alignment: .top, spacing: 15) {
                ForEach(options, id: \.self) { option in
                    VStack(spacing: 2) {
                        Text(option)
                            .frame(maxWidth: .infinity)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            
                        
                        if selection == option {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.blue)
                                .frame(width: 100,height: 2)
                                .matchedGeometryEffect(id: "selection", in: namespase)
                        }
                    }
                    .padding(.top, 8)
                    .background(.black.opacity(0.001))
                    .foregroundStyle(selection == option ? .bumbleBlack  : .bumbleGray)
                    .onTapGesture {
                        selection = option
                    }
                }
            }
            .animation(.smooth, value: selection)
            
        }
    }

/*
 🔥 Эта структура временный родитель
    ◉ Она нужна для привью что бы можно было посмотреть работу компонентов на Canvas , но так как BumbleFilterView - это многоразовая структура и она не должна владеть состоянием @State(@State всегда у родителя❕). BumbleFilterView только рисует UI, мы связали их с BumbleFilterViewPreview через @Binding что бы посмотреть на привью как отрабатывают компаненты
 🟢 fileprivate - приватная, ее можно использовать только в этом файле!(она и создана только для этого файла)
 */
fileprivate struct BumbleFilterViewPreview: View {
    
    var options: [String] = ["Everyone", "Trending"]
    @State private var selection = "Everyone"
    
    var body: some View {
        BumbleFilterView(options: options, selection: $selection)
    }
}

#Preview {
    BumbleFilterViewPreview()
        .padding()
        
}
