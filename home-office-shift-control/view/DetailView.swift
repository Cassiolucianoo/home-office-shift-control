//
//  DetailView.swift
//  home-office-shift-control
//
//  Created by cassio on 30/03/23.
//

import SwiftUI



struct DetailView: View {
    
    @State var isAlert = false
    @ObservedObject private var inputTitle = TextLimiter(limit: 60)
    @ObservedObject private var inputDescription = TextLimiter(limit: 100)
    @State private var dataSelecionada = Date()
    @State private var wordCount: Int = 0
    @State private var mostrarData = false
    
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var title: String
    @Binding var description: String
    let item: PostModel
    @EnvironmentObject var viewModel: ViewModel
    
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
                        Text("11/ 06/ 2023 21:52")
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
                
                TextField("Exemplo: Desenvolvendo view", text: $inputTitle.value)
                
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                Text("Descrição")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                TextEditor(text: $inputTitle.value)
                    .frame(height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                Text ("\(wordCount) Caracteres")
                   
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                
            }.padding()
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




//struct DetailView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var title: String
//    @Binding var description: String
//    let item: PostModel
//    @EnvironmentObject var viewModel: ViewModel
//
//    var body: some View {
//        ZStack {
//            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
//            VStack(alignment: .leading) {
//                Text("Criar tarefa")
//                    .font(Font.system(size: 16, weight: .bold))
//
//                TextField("Titulo", text: $title)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(6)
//                    .padding(.bottom)
//
//                TextField("Descrição da tarefa", text: $description)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(6)
//                    .padding(.bottom)
//
//                Spacer()
//            }
//            .padding()
//            .onAppear {
//
//                self.title = item.title
//                self.description = item.description
//            }
//        }
//        .navigationBarTitle("Editar tarefa realizada", displayMode: .inline)
//        .navigationBarItems(trailing: trailing)
//    }
//
//
    
    
    
    
    
    
    
    
//
//    var trailing: some View {
//        Button(action: {
//            if title != "" && description != "" {
//                let parameters: [String: String] = ["id": "\(item.id)", "title": title, "description": description]
//                do {
//                    let jsonData = try JSONEncoder().encode(parameters)
//                    if let jsonString = String(data: jsonData, encoding: .utf8) {
//                        let updateParameters = ["data": jsonString]
//                        viewModel.updatePost(parameters: updateParameters, id: item.id)
//                        viewModel.fetchPost()
//                        presentationMode.wrappedValue.dismiss()
//                        print(item.id)
//                    }
//                } catch {
//                    print("Error encoding parameters:", error.localizedDescription)
//                }
//            }
//        }) {
//            Text("Salvar")
//        }
//    }
//
    
    
    
    
//}
