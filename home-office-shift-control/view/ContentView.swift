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
            }
            .navigationTitle("Tarefas")
            .onAppear(perform: vm.fetchTarefas)
            
            .alert(isPresented: $vm.hasError) {
                
                return Alert(title: Text("Erro ao carregar sua lista"),
                             message: Text("Ocorreu um erro verifique seu acesso a rede, tente novamente mais tarde"),
                             dismissButton: .default(Text("Ok")))
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
