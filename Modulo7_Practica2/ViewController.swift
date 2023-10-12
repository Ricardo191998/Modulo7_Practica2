//
//  ViewController.swift
//  Modulo7_Practica2
//
//  Created by Ricardo Rosales Romero on 10/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableNotes: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notes : [Note] = []
    var notesDataManager : NoteDataManager?
    let postService = PostServiceManager()
    var selectNote : Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableNotes.delegate = self
        tableNotes.dataSource = self
        
        notesDataManager = NoteDataManager(context: context)
        
        notes = notesDataManager!.getAllNotes()
    
    }
    
    func refresh(){
        notes = notesDataManager!.getAllNotes()
        tableNotes.reloadData()
        
    }
    
    @IBAction func deleteNote(segue: UIStoryboardSegue){
        postService.deletePost(id: selectNote!.idNote){deletedPost in
            if  deletedPost == 0 {
                print("Error: Failed to delete post")
            } else {
                if self.notesDataManager!.deleteNote(note: self.selectNote!){
                    print("Se borro con exito")
                    DispatchQueue.main.async {
                        self.refresh()
                    }
                }else {
                    print("No se pudo borrar")
                }
            }
        }
    }

    @IBAction func saveNoteFromAddNoteController(segue: UIStoryboardSegue){
            
        let source = segue.source as! DetailNoteController
        
        if source.isUpdate {
            let myPost =  Post(id: Int(selectNote!.idNote), title: source.titleNote, body: source.body, userId: Int(selectNote!.userId))
            postService.updatePost(post: myPost){ updatedPost in
                if let updatedPost = updatedPost{
                    print("updated post", updatedPost)
                    if let noteUpdate = self.notesDataManager?.updateNote(note: self.selectNote! ,title: source.titleNote, body: source.body, userId: self.selectNote!.userId){
                        DispatchQueue.main.async {
                            self.refresh()
                        }
                    }
                    else {
                        print("Error: Fallo actualizar la nota")
                    }
                } else {
                    print("Error: Failed to create post")
                }
            }
        } else {
            let myPost =  Post(id: nil, title: source.titleNote, body: source.body, userId: 1)
            postService.createPost(post: myPost){ createdPost in
                if let createdPost = createdPost{
                    print("created post", createdPost)
                    if let noteUpdate = self.notesDataManager?.createNote(title: source.titleNote, id: Int16(createdPost.id!), body: source.body, userId: 1) {
                        DispatchQueue.main.async {
                            self.refresh()
                        }
                    } else {
                        print("Error: Fallo crear la nota")
                    }
                } else {
                    print("Error: Failed to create post")
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "updateSegue"){
            let destination = segue.destination as! DetailNoteController
            destination.isUpdate = true
            destination.currentNote = selectNote
            print(selectNote?.idNote)
        }
    }
}

extension  ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NotesCell
               
        let noteItem = notes[ indexPath.row]
        cell.title.text = noteItem.title
        cell.body.text = noteItem.body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectNote = notes[indexPath.row]
        self.performSegue(withIdentifier: "updateSegue", sender: Self.self)
    }
    
    
}

