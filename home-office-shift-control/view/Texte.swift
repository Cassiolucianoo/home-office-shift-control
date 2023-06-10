//
//  SwiftUIView.swift
//  home-office-shift-control
//
//  Created by cassio on 09/06/23.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var isAlert = false
    @ObservedObject private var inputTitle = TextLimiter(limit: 60)
    @ObservedObject private var inputDescription = TextLimiter(limit: 100)
    @State private var dataSelecionada = Date()
    @State private var wordCount: Int = 0
    
    var body: some View {
        
        NavigationView{
            VStack{
                
                Text("Titulo da tarefa")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                TextField("Exemplo: Desenvolvendo view", text: $inputTitle.value)
                
                    .padding(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { Text("Data") })
                
                Text("Descrição")
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextEditor(text: $inputTitle.value)
                    .frame(height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                Text ("\(wordCount) Caracteres")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
            }.padding()
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
    
    var leading: some View{
        Button(action: {
            print("Cancelar  4558")
            
        }, label: {
            Image(systemName: "x.circle.fill")
                .foregroundColor(.red)
                .font(.system(size: 30))
        })
    }
    
    var trailing: some View{
        Button(action: {
            // title = inputTitle.value
            // description = inputDescription.value
            // date =  dateFormatte.string(from: self.dataSelecionada)
            
            
            
            //                if title != "" && description != "" {
            //                    let parameters: [String: Any] = ["title": title, "description": description, "date": dateFormatte.string(from: self.dataSelecionada)]
            //                    viewwModel.createPost(parameters: parameters)
            //                    viewwModel.fetchPost() // Atualiza a lista imediatamente após adicionar o item
            //                    isPresented.toggle()
            //                    print("Adicionando")
            //                } else {
            //                    isAlert.toggle()
            //                }
            
            
        }, label: {
            Image(systemName: "doc.fill.badge.plus")
                .foregroundColor(.green)
                .font(.system(size: 30))
        })
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(  )
    }
}
