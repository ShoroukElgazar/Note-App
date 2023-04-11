//
//  EmptyStateViewModifier.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/10/23.
//

import SwiftUI

struct EmptyStateViewModifier<EmptyContent>: ViewModifier where EmptyContent: View {
    var isEmpty: Bool
    let emptyContent: () -> EmptyContent
    
    func body(content: Content) -> some View {
        if isEmpty {
            emptyContent()
        }else{
            content
        }
    }
}
