//
//  ContentView.swift
//  home-office-shift-control
//
//  Created by cassio on 25/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = TarefasViewModel()
    
    var body: some View {
        NavigationView{
            ZStack {
                List{
                    
                    ForEach(vm.tarefas, id: \.id ){ user in
                        TarefaView(tarefa: user)
                    }
                }
                .navigationTitle("Tarefas")
            }
            .onAppear(perform: vm.fetchTarefas)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
