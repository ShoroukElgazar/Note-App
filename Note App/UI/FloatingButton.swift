//
//  FloatingButton.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/10/23.
//

import SwiftUI

struct FloatingButton<Content: View>: View {
    var destination: Content
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: destination) {
                    Text("+")
                        .font(.system(size: 25))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                }.frame(width: 50,height: 50)
                .foregroundColor(.white)
                .background(Color.indigo)
                .cornerRadius(30)
                .padding(30)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)

            }
        }
    }
}



