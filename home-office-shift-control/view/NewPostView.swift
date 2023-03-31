//
//  NewPostView.swift
//  home-office-shift-control
//
//  Created by cassio on 30/03/23.
//

import SwiftUI

struct NewPostView: View {
    @Binding var title :String
    @Binding var post: String
    @Binding var isPresented: Bool
    @EnvironmentObject var viewwModel: ViewModel
    @State var isAlert = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    Text("Crear uma nova tarefa")
                        .font(Font.system(size: 16, weight:.bold))
                    
                    TextField("Titulo da atividade", text: $title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    TextField("Informe a tarefa para postar", text: $post)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    Spacer()
                }.padding()
                .alert(isPresented: $isAlert) {
                    let title = Text("CAMPOS EM BRANCO")
                    let message = Text("Todos os campos são obrigatorios!")
                    return Alert(title: title, message: message)
                }
            }
            .navigationBarTitle("Nova tarefa", displayMode: .inline)
            .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
    
    var leading: some View{
        Button(action: {
            print("Cancelar  4558")
            isPresented.toggle()
        }, label: {
            Text("Cancela")
            
        })
    }
    
    var trailing: some View{
        Button(action: {
            if title != "" && post != "" {
                let parameters: [String: Any] = ["title" : title, "post":post]
                viewwModel.createPost(parameters: parameters)
                viewwModel.fetchPost()
                isPresented.toggle()
                
            }else {
                isAlert.toggle()
            }
        }, label: {
            Text("publicar")
            
        })
    }
    
}
