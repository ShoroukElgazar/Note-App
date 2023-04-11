//
//  TextEditorView.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/10/23.
//

import SwiftUI

struct TextEditorView: View {
    
    @Binding var string: String
    @State private var textEditorHeight : CGFloat = CGFloat()

    var body: some View {
        
        ZStack(alignment: .leading) {

            Text(string)
                .lineLimit(5)
                .foregroundColor(.clear)
                .padding(.top, 5.0)
                .padding(.bottom, 7.0)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
            
            TextEditor(text: $string)
                .frame(height: UIScreen.main.bounds.height - 300)
                .scrollContentBackground(.hidden)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
 
        }
        .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
        
    }
    
    struct ViewHeightKey: PreferenceKey {
        static var defaultValue: CGFloat { 0 }
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = value + nextValue()
        }
    }
}

