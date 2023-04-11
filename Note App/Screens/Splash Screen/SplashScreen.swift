//
//  SplashScreen.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/11/23.
//

import SwiftUI

struct SplashScreen: View {
    @ObservedObject var vm: SplashVM
    @State private var isActive = false
    @State var showSplash = false
    
    var body: some View {
        if isActive{
            TabsView.build()
        }else{
            VStack{
                
                Image("splash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showSplash =  true
                        isActive = true
                    }
                }
            }
            .fullScreenCover(isPresented: $showSplash) {
                NotesView.build()
            }
        }
    }
}

extension SplashScreen {
    static func build() -> some View {
        let vm = SplashVM(
                repos: Repos.build()
        )
        return SplashScreen(vm: vm)
    }
}

