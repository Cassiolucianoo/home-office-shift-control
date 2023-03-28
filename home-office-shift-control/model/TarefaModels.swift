//
//  Tarefa.swift
//  home-office-shift-control
//
//  Created by cassio on 26/03/23.
//

import Foundation
import SwiftUI

struct Tarefa: Decodable{
    
    let tarefa: String
    let tempoInicio: String
    let tempoFim: String
    let descricao: String
    let data: [PostTarefa]
    
}

struct PostTarefa: Decodable {
    let id: Int
    let title: String
    let post : String
    
}
