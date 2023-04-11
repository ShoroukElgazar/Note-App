//
//  TabsView.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/10/23.
//

import SwiftUI

struct TabsView: View {
    
    var body: some View {
        TabViewField()
    }
    
    private func TabViewField() -> some View {
        TabView {
            NotesView.build()
                       .tabItem {
                           Image(systemName: "square.and.pencil.circle.fill")
                           Text(Strings.inprogress)
                       }
                   
                   
            CompletedNotesView.build()
                       .tabItem {
                           Image(systemName: "checkmark.circle.fill")
                           Text(Strings.completed)
                       }
                   
//            ActivityView.build()
//                       .tabItem {
//                           Image(systemName: "3.circle")
//                           Text("Activity")
//                       }
        }.accentColor(.indigo)
    }
}

extension TabsView{
    static func build() -> some View{
        return TabsView()
    }
}
