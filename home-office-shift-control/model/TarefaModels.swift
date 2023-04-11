//
//  Tarefa.swift
//  home-office-shift-control
//
//  Created by cassio on 26/03/23.
//

import Foundation
import SwiftUI

struct DataModel: Decodable{
    
    let error: Bool
    let message: String
    let data: [PostModel]
    
}

struct PostModel: Decodable {
    let id: Int
    let title: String
    let description : String
    let date : String
}
