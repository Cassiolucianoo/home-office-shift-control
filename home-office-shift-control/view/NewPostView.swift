//
//  NewPostView.swift
//  home-office-shift-control
//
//  Created by cassio on 30/03/23.
//

import SwiftUI

struct NewPostView: View {
    @Binding var title :String
    @Binding var description: String
    @Binding var date: String
    @Binding var isPresented: Bool
    @EnvironmentObject var viewwModel: ViewModel
    @State var isAlert = false
    @State private var wordCount: Int = 0
    @State private var dataSelecionada = Date()
    @ObservedObject private var inputTitle = TextLimiter(limit: 45)
    @ObservedObject private var inputDescription = TextLimiter(limit: 100)
    private let dateFormatte = formate
    

    var body: some View {
        
        NavigationView{
            VStack(spacing: 10){

                Text("Titulo da tarefa")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                TextField("Exemplo: Desenvolvendo view", text: $inputTitle.value)
                
                    .padding(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
               // DatePicker("Data inicio: ", selection: $dataSelecionada)
                DatePicker(selection: $dataSelecionada, label: { Text("Data para inicio").bold() })
                
                Text("Descrição")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextEditor(text: $inputDescription.value)
                    .frame(height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                Text ("\(wordCount) Caracteres")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
            }
            
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .accentColor(.black)
                .navigationTitle("Criar tarefa")
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
            
                .navigationBarTitle("Nova tarefa", displayMode: .inline)
                .navigationBarItems(leading: leading, trailing: trailing)
            
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
    
    struct Footer: View {
        @Binding var wordCounts: Int
        var body: some View {
            Text ("\(wordCounts) Caracteres")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 15))
                .foregroundColor(.secondary)
        }
    }
    
    var leading: some View{
        Button(action: {
            print("Cancelar  4558")
            isPresented.toggle()
        }, label: {
            Image(systemName: "x.circle.fill")
                .foregroundColor(.black)
                .font(.system(size: 25))
  
        })
    }
    
    var trailing: some View{
        Button(action: {
            title = inputTitle.value
            description = inputDescription.value
            date =  dateFormatte.string(from: self.dataSelecionada)
            
            
            
            if title != "" && description != "" {
                let parameters: [String: Any] = ["title": title, "description": description, "date": dateFormatte.string(from: self.dataSelecionada)]
                viewwModel.createPost(parameters: parameters)
                viewwModel.fetchPost() // Atualiza a lista imediatamente após adicionar o item
                isPresented.toggle()
                print("Adicionando")
            } else {
                isAlert.toggle()
            }

            
        }, label: {
            Image(systemName: "doc.fill.badge.plus")
                .foregroundColor(.black)
                .font(.system(size: 25))
        })
    }
    
   
}
