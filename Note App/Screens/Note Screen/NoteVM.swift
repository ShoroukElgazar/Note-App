//
//  NoteVM.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/6/23.
//

import Combine
import SwiftUI
import CoreData

class NoteVM: ObservableObject{
    public var repos: ReposContract
    @Published var completedNotesCount = 0.0
    @Published var allNotesCount = 0.0
    @Published var progress = 0.0
     
    public init(repos: ReposContract) {
        self.repos = repos
        loadProgress()
    }
  
    func addItem(note: NoteModel) {
        repos.note.addNote(note: note)
       }
    
    func deleteNote(note: NoteModel) {
        repos.note.deleteNote(note: note)
    }
    
    func editNote(note: NoteModel) {
        repos.note.editNote(note: note)
    }
    
    func shareNote(note: NoteModel) -> [Any]{
        repos.note.shareNote(note: note)
    }
  
    func mapNoteEntityToModel(note: Note) -> NoteModel{
        NoteItemMapper().map(note)
    }
    func loadProgress(){
        progress = (completedNotesCount / allNotesCount ) * 100
    }
}

enum NoteType{
    case completed
    case incompleted
}
