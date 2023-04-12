//
//  CompletedNotesView.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/9/23.
//

import SwiftUI
import CoreData

struct CompletedNotesView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Note>
    @State var searchText: String = ""
    @State var title: String = ""
    @State var data: String = ""
    @State var isCompleted: Bool = false
    @State var vm : NoteVM
    @State private var stroken = false
    @Environment(\.managedObjectContext) private var viewContext
    let persistenceController = PersistenceController.shared
    @State private var showShareSheet: Bool = false
    @State var shareSheetItems: [Any] = []
    var body: some View {
        NavigationView {
            VStack{
//                SearchBar(text: $searchText)
            ZStack
                {
                    NoteListView(searchText: $searchText, vm: vm,type: .completed,shareCompletion: { item in
                        shareNote(item: item)
                    }, deleteCompletion: { item in
                        deleteNote(item: vm.mapNoteEntityToModel(note: item))
                    }, playSoundCompletion: {
                        
                    })
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text(Strings.completedNotes)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                        }
                    }
                    .sheet(isPresented: $showShareSheet, content: {
                        ActivityViewController(activityItems: self.$shareSheetItems)
                    })
                }
            }
        }
    }


    private func deleteNote(item: NoteModel) {
        withAnimation {
            vm.deleteNote(note: item)
        }
    }
    private func getCompletedNotes() ->  [FetchedResults<Note>.Element] {
      items.filter { $0.isCompleted}
    }

    
    private func shareNote(item: Note){
        showShareSheet = true
        let shareItems = vm.shareNote(note: vm.mapNoteEntityToModel(note: item))
        shareSheetItems = shareItems
    }
}


extension CompletedNotesView{
    static func build() -> some View{
        let vm = NoteVM(
                repos: Repos.build())
        return CompletedNotesView(vm: vm)
    }
}
