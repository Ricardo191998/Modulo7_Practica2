//
//  NotesCell.swift
//  Modulo7_Practica2
//
//  Created by Ricardo Rosales Romero on 10/10/23.
//

import UIKit

class NotesCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
