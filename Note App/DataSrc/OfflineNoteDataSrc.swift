//
//  OfflineNoteDataSrc.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/9/23.
//

import Combine
import CoreData
import SwiftUI

protocol NoteDataSrcProtocol {
    func addNote(note: NoteModel)
    func deleteNote(note: NoteModel)
    func editNote(note: NoteModel)
    func shareNote(note: NoteModel) -> [Any]
}

struct OfflineNoteDataSrc: NoteDataSrcProtocol {
    var viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
   
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
    
    func addNote(note: NoteModel) {
        _ = NoteEntityMapper(viewContext: viewContext).map(note)
        saveContext()
    }
    
    func deleteNote(note: NoteModel) {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "timestamp == %@", note.timeStamp as NSDate)

        do {
            let notes = try viewContext.fetch(fetchRequest)
            for note in notes {
                viewContext.delete(note)
            }
            try viewContext.save()
        } catch {
            print("Error deleting note: \(error.localizedDescription)")
        }
    }

    func editNote(note: NoteModel) {
        saveContext()
    }
    
    func shareNote(note: NoteModel) -> [Any]{
        return ["Title \(note.title)","\n \(note.data)"]
    }
    
    func loadNotes(input: FetchedResults<Note>) -> [NoteModel]{
        var notes : [NoteModel] = []
        for item in input{
            notes.append(NoteItemMapper().map(item))
        }
      return notes
    }
  
  
}



