//
//  NoteRepo.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/9/23.
//

import Foundation

 public struct NoteRepo {
public static let shared = NoteRepo.build()
     let offlineSrc: OfflineNoteDataSrc
     
     func addNote(note: NoteModel) {
         offlineSrc.addNote(note: note)
     }
     
     func deleteNote(note: NoteModel) {
         offlineSrc.deleteNote(note: note)
     }
     
     func editNote(note: NoteModel) {
         offlineSrc.editNote(note: note)
     }
     
     func shareNote(note: NoteModel) -> [Any]{
         offlineSrc.shareNote(note: note)
     }

}

 extension NoteRepo {

    static func build() -> NoteRepo {
        NoteRepo(offlineSrc: OfflineNoteDataSrc())
    }
    
}
