//
//  UserView.swift
//  home-office-shift-control
//
//  Created by cassio on 27/03/23.
//

import SwiftUI

struct TarefaView: View {
    
    let tarefa: Tarefa
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(" Tarefa : \(tarefa.tarefa)")
            Divider()
            Text(" Descrição da tarefa: \(tarefa.descricao)")
            Text("Tempo: \(tarefa.tempoInicio)")
            Text("Tempo Final: \(tarefa.tempoFim)")
            
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1))
        
        .padding(.horizontal, 4)
        
    }
}

//struct TarefaView_Previews: PreviewProvider {
//    static var previews: some View {
//        TarefaView(tarefa: .init (id: 0, tarefa: " Programa app", tempoInicio: " 12:00", tempoFim: " ", descricao: " "))
//    }
//}

