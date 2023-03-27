//
//  ContentView.swift
//  home-office-shift-control
//
//  Created by cassio on 25/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = UsersViewModel()
    
    var body: some View {
        NavigationView{
            ZStack {
                List{
                    
                    ForEach(vm.users, id: \.id ){ user in
                        TarefaView(tarefa: user)
                    }
                }
                .navigationTitle("Tarefas")
            }
            .onAppear(perform: vm.fetchUsers)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
