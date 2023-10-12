//
//  NoteDataManager.swift
//  Modulo7_Practica2
//
//  Created by Ricardo Rosales Romero on 10/10/23.
//

import Foundation
import CoreData


class NoteDataManager{
    private let context : NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createNote(title: String, id: Int16, body : String, userId: Int16) -> Note?{
        let newNote = Note(context: context)
        newNote.title = title
        newNote.idNote = id
        newNote.body = body
        newNote.userId = userId
        
        do{
            try context.save()
            return newNote
        }catch let error {
            print(error)
            return nil
        }
    }
    
    
    func getAllNotes()-> [Note]{
        if let notes = try? self.context.fetch(Note.fetchRequest()){
            print(notes)
            
            return notes
        } else {
            return []
        }
    }
    
    func getNoteById (id: Int16) -> Note? {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        var predicate: NSPredicate?
        
        predicate = NSPredicate(format: "noteId = %@", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        if let note = try? self.context.fetch(fetchRequest){
            return note.first
        } else {
            return nil
        }
    }

    
    
    func updateNote (note: Note, title: String, body: String, userId: Int16) -> Note? {
        print("Actualizacion")
        print(body)
        print(title)
        note.title = title
        note.body = body
        note.userId = userId
        
        do {
            try context.save()
            return note
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func deleteNote(note: Note) -> Bool {
        self.context.delete(note)
        do{
            try context.save()
            return true
        }catch let error {
            print(error)
            return false
        }
    }
}
