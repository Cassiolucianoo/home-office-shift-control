//
//  DetailView.swift
//  home-office-shift-control
//
//  Created by cassio on 30/03/23.
//

import SwiftUI

struct DetailView: View {
    
    @State private var isAlert = false
    @State private var wordCount: Int = 0
    @ObservedObject private var inputTitle = TextLimiter(limit: 60)
    @ObservedObject private var inputDescription = TextLimiter(limit: 120)
    @State private var mostrarData = false
    
    
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State  var description = ""
    @State var dateText  = ""
    let item : PostModel
    
    
    @EnvironmentObject var viewwModel: ViewModel
    
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 15){
                
                Divider()
                
                Text("status da tarefa")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Toggle(isOn: $mostrarData){
                    
                }.toggleStyle(SwitchToggleStyle(tint: .black))
                
                
                HStack {
                    VStack{
                        Text("Inicio da tarefa")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(dateText)
                            .font(.system(size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    if mostrarData {
                        VStack{
                            Text("Tarefa finalziada")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Text("11/ 06/ 2023 21:52")
                                .font(.system(size: 14))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }}
                    
                }
                
                Text("Titulo da tarefa")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextField("Exemplo: Desenvolvendo view", text: $title)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .onChange(of: title) { newValue in
                        let filtered = newValue.prefix(inputTitle.limit)
                        if filtered != newValue {
                            self.title = String(filtered)
                        }
                        wordCount = self.title.count
                    }
                
                Text("Descrição")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextEditor(text: $description)
                    .frame(height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .onChange(of: description) { newValue in
                        let filtered = newValue.prefix(inputDescription.limit)
                        if filtered != newValue {
                            self.description = String(filtered)
                        }
                        wordCount = self.description.count
                    }
                Text ("\(wordCount) Caracteres")
                
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
            }
            .onAppear {
                
                self.title = item.title
                self.description = item.description
                self.dateText = item.date
            }
            
            
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .accentColor(.black)
            .navigationTitle("Editar tarefa")
            .onChange(of: inputDescription.value , perform: { value in
                print("Contin Entrada da tecla\(self.wordCount)")
                let words = value.count
                self.wordCount = words
            })
            
            .alert(isPresented: $isAlert) {
                let title = Text("CAMPOS EM BRANCO")
                let message = Text("Todos os campos são obrigatorios!")
                return Alert(title: title, message: message)
            }
            
            .navigationBarTitle("Criar tarefa", displayMode: .inline)
            .navigationBarItems(trailing: trailing)
            
            .onChange(of: inputDescription.value , perform: { value in
                print("Contin Entrada da tecla\(self.wordCount)")
                let words = value.count
                self.wordCount = words
            })
            
        }
        .onTapGesture {
            hideKeybord()
        }
    }

    var trailing: some View{
        Button(action: {
            
            
            if title != "" && description != "" {
                let parameters: [String: Encodable] = ["id": item.id, "title": title, "description": description, "date": dateText]
                let id  = item.id
                viewwModel.updatePost(parameters: parameters, id: id)
                viewwModel.fetchPost()
                presentationMode.wrappedValue.dismiss()
                print(item.id)
            }
            
            
        }, label: {
            ZStack {
                Image("edit2")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                Text("Editar")
                    .foregroundColor(.black)
                    .font(.system(size: 12))
                    .offset(x: 0, y: 20) // Ajuste o valor do deslocamento conforme necessário
            }

        })
    }
    
}
