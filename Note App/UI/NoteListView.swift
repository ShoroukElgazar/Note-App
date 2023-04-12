//
//  NoteView.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/10/23.
//

import SwiftUI

struct NoteListView: View{
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.timestamp, ascending: true)],
        animation: .default)
    
     var items: FetchedResults<Note>
   @Binding var searchText : String
    var vm : NoteVM
    var type: NoteType
    var shareCompletion: (Note) -> Void
    var deleteCompletion: (Note) -> Void
    var playSoundCompletion: () -> Void
    @State private var completedNotesCount = 0.0
    @State private var inCompletedItems : [FetchedResults<Note>.Element] = []
    
    var body: some View {
        VStack{
            ListView()
        }
        }
    
    private func ListView() -> some View {
        let isEmpty = (type == .completed ? loadCompletedNotes(searchText: searchText) : loadInCompletedNotes(searchText: searchText)).isEmpty
      return  VStack{
            if isEmpty{
              EmptyField()
            }else{
                NoteList()
            }
        }
    }
    
    private func EmptyField() -> some View {
        VStack{
            Image("note")
                .resizable()
                .padding()
                .frame(width: 100,height: 100)
            Text(Strings.noNotes)
                .font(.title3)
                .foregroundColor(Color.indigo)
        }
    }
    private func NoteList() -> some View {
        List {
            ForEach(type == .completed ? loadCompletedNotes(searchText: searchText) : loadInCompletedNotes(searchText: searchText)) { item in
                ZStack{
                    NoteItem(item: item)
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                shareCompletion(item)
                            } label: {
                                Label(Strings.share, systemImage: "square.and.arrow.up.fill")
                            }
                            .tint(.indigo)
                            Button(role: .destructive) {
                                deleteCompletion(item)

                            } label: {
                                Label(Strings.delete, systemImage: "trash.fill")
                            }
                        }
                    
                    NavigationLink(destination:  NoteDetails(vm: vm, selectedNote: item,title: item.title!,details: item.data!)
                    ){
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                        .opacity(0)
                    
                }
            }.listRowSeparator(.hidden)
                .background(Color.clear)
                .listStyle(.plain)
                .listRowBackground(Color.clear)
            
        }.listStyle(.plain)
//            .searchable(text: $searchText)
//            .foregroundColor(Color.indigo)
    }
    
    private func NoteItem(item: Note) -> some View {
        VStack{
            HStack{
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isCompleted ? Color.indigo : Color.secondary)
                    .onTapGesture {
                        item.isCompleted.toggle()
                            vm.editNote(note: vm.mapNoteEntityToModel(note: item))
                            if item.isCompleted{
                               playSoundCompletion()
                        }
                    }
                Text(item.title!)
                    .foregroundColor(.indigo)
                    .strikethrough(type == .completed ? true : false)
                Spacer().frame(maxWidth: .infinity)
               
            }.padding()
                .background(Color.indigo.opacity(0.2))
                .cardView()
                .cornerRadius(5)
                .shadow(radius: 3)
        }
    }
    
    private func loadInCompletedNotes(searchText: String) ->  [FetchedResults<Note>.Element] {
        let filteredNotes = items.filter { !$0.isCompleted}
        return loadFilteredNotes(searchText: searchText, notes: filteredNotes)
    }

    private func loadCompletedNotes(searchText: String) ->  [FetchedResults<Note>.Element] {
        let filteredNotes = items.filter { $0.isCompleted}
        return loadFilteredNotes(searchText: searchText, notes: filteredNotes)
    }
    
    private func loadFilteredNotes(searchText: String,notes: [FetchedResults<Note>.Element])->  [FetchedResults<Note>.Element] {
        if searchText.isEmpty{
            return notes
        }else{
            return notes.filter { note in
                return note.title?.range(of: searchText, options: [.caseInsensitive, .diacriticInsensitive]) != nil
            }
        }
    }
}

