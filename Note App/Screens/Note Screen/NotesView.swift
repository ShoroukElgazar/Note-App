//  NotesView.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/6/23.
//
//
import SwiftUI
import CoreData
import AVFoundation

struct NotesView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.timestamp, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Note>
    //TODO:- sound
    let player = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "sound", ofType: "mp3")!))
    @State var title: String = ""
    @State var data: String = ""
    @State var isCompleted: Bool = false
    @State var vm : NoteVM
    @State private var stroken = false
    @Environment(\.managedObjectContext) private var viewContext
    let persistenceController = PersistenceController.shared
    @State private var showShareSheet: Bool = false
    @State var shareSheetItems: [Any] = []
    @State private var searchText = ""
    @State var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                SearchBar(text: $searchText)
                ZStack
                {
                    NoteListView(searchText: $searchText, vm: vm,type: .incompleted,shareCompletion: { item in
                        shareNote(item: item)
                    }, deleteCompletion: { item in
                        deleteNote(item: vm.mapNoteEntityToModel(note: item))
                    }, playSoundCompletion: {
                        player?.play()
                    })
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text(Strings.noteAPP)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                        }
                    }
                    .sheet(isPresented: $showShareSheet, content: {
                        ActivityViewController(activityItems: self.$shareSheetItems)
                    })
                    AddButton()
                    
                }
            }
        }
    }
    
    private func AddButton() -> some View {
            FloatingButton(destination:   AddNoteView.build()
                .environment(\.managedObjectContext,self.viewContext)
            )
        }
    
    private func deleteNote(item: NoteModel) {
        withAnimation {
            vm.deleteNote(note: item)
        }
    }
    

    private func shareNote(item: Note){
        showShareSheet = true
        let shareItems = vm.shareNote(note: vm.mapNoteEntityToModel(note: item))
        shareSheetItems = shareItems
    }

}

extension NotesView{
    static func build() -> some View{
        let vm = NoteVM(
            repos: Repos.build())
        return NotesView(vm: vm)
    }
}
