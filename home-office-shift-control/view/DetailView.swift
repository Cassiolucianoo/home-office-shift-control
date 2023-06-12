//
//  DetailView.swift
//  home-office-shift-control
//
//  Created by cassio on 30/03/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var title: String
    @Binding var description: String
    let item: PostModel
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Text("Criar tarefa")
                    .font(Font.system(size: 16, weight: .bold))
                
                TextField("Titulo", text: $title)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)
                
                TextField("Descrição da tarefa", text: $description)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(.bottom)
                
                Spacer()
            }
            .padding()
            .onAppear {
                
                self.title = item.title 
                self.description = item.description 
            }
        }
        .navigationBarTitle("Editar tarefa realizada", displayMode: .inline)
        .navigationBarItems(trailing: trailing)
    }
    
    var trailing: some View {
        Button(action: {
            if title != "" && description != "" {
                let parameters: [String: String] = ["id": "\(item.id)", "title": title, "description": description]
                do {
                    let jsonData = try JSONEncoder().encode(parameters)
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        let updateParameters = ["data": jsonString]
                        viewModel.updatePost(parameters: updateParameters, id: item.id)
                        viewModel.fetchPost()
                        presentationMode.wrappedValue.dismiss()
                        print(item.id)
                    }
                } catch {
                    print("Error encoding parameters:", error.localizedDescription)
                }
            }
        }) {
            Text("Salvar")
        }
    }
}
