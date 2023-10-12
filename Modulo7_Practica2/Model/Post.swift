//
//  Post.swift
//  Modulo7_Practica2
//
//  Created by Ricardo Rosales Romero on 10/10/23.
//

import Foundation

struct Post : Codable{
    let id: Int?
    let title: String
    let body: String
    let userId: Int
}
