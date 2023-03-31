//
//  DetailView.swift
//  home-office-shift-control
//
//  Created by cassio on 30/03/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State  var post = ""
    let item : PostModel
    @EnvironmentObject var viewwModel: ViewModel
    
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                Text("Criar tarefa")
                    .font(Font.system(size: 16, weight:.bold))
                
                TextField("Titulo", text: $title)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)
                
                TextField("Descrição da tarefa", text: $post)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)
                
                Spacer()
            }.padding()
            .onAppear(perform: {
                self.title = item.title
                self.post = item.post
            })
        }
        .navigationBarTitle("Editar tarefa realisada", displayMode: .inline)
        .navigationBarItems(trailing: trailing)
    }
    
    
    var trailing: some View{
        Button(action: {
            
            if title != "" && post != "" {
                let parameters: [String: Any] = ["id": item.id, "title": title, "post": post]
                let id  = item.id
                viewwModel.updatePost(parameters: parameters, id: id)
                
                
                viewwModel.fetchPost()
                presentationMode.wrappedValue.dismiss()
                print(item.id)
            }
            
        }, label: {
            Text("Salvar")
        })
    }
}

