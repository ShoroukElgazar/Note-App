//
//  NoteModel.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/9/23.
//

import Foundation
import ModelMapper
import  CoreData
import SwiftUI

public struct NoteModel{
    var title: String
    var data: String
    var isCompleted: Bool
    var timeStamp: Date
}

public class NoteItemMapper: Mapper {
    public func map(_ input: Note) -> NoteModel {
        return NoteModel(title: input.title!, data: input.data!, isCompleted: input.isCompleted, timeStamp: input.timestamp!)
    }
}

public class NoteEntityMapper: Mapper {

var viewContext: NSManagedObjectContext
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    public func map(_ input: NoteModel) -> Note {
        let newItem = Note(context: viewContext)
        newItem.timestamp = input.timeStamp
        newItem.title = input.title
        newItem.data = input.data
        newItem.isCompleted = input.isCompleted
        return newItem
    }
}
