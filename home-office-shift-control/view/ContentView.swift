//
//  ContentView.swift
//  home-office-shift-control
//
//  Created by cassio on 25/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = TarefasViewModel()
    @State private var taskName: String = ""
    @State private var tasks: [String] = []
    @StateObject private var todoListVM = TarefasViewModel()
    
    private func deleteTask(indexSet: IndexSet) {
        indexSet.forEach { index in
            tasks.remove(at: index)
        }
    }
    
    
    var body: some View {
        
        NavigationView{
            ZStack {
                
//                List{
//                   ForEach(vm.tarefas, id: \.id ){ user in
//                        TarefaView(tarefa: user)
//                    }.onDelete { indexSet in
//                        vm.tarefas.remove(atOffsets: indexSet)
//
//                    }
//                }.onTapGesture {
//                    ForEach(vm.tarefas, id: \.id ){ user in
//                         TarefaView(tarefa: user)
//                     }
//               }

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
