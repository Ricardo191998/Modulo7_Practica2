//
//  DetailNoteController.swift
//  Modulo7_Practica2
//
//  Created by Ricardo Rosales Romero on 10/10/23.
//

import UIKit

class DetailNoteController: UIViewController {

    @IBOutlet var deleteButton: UIButton!
    var titleNote: String = ""
    var body: String = ""
    
    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textDesc: UITextField!
    
    var currentNote : Note?
    var isUpdate : Bool = false
    
    @IBOutlet var rigthButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       if(isUpdate) {
           rigthButton.title = "Actualizar"
           textTitle.text = currentNote?.title
           textDesc.text = currentNote?.body
           titleNote = currentNote?.title ?? ""
           body = currentNote?.body ?? ""
           deleteButton.isHidden = false
       } else {
           rigthButton.title = "Guardar"
           deleteButton.isHidden = true
       }
       
   }
    
    @IBAction func titleEvent(_ sender: UITextField) {
        titleNote = sender.text!
    }
    
    @IBAction func descEvent(_ sender: UITextField) {
        body = sender.text!
    }
    

}
