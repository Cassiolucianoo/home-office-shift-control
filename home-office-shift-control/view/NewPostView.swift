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
    @ObservedObject private var inputTitle = TextLimiter(limit: 60)
    @ObservedObject private var inputDescription = TextLimiter(limit: 100)
    private let dateFormatte = formate
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    Text("Titulo da tarefa")
                        .font(Font.system(size: 16, weight:.bold))
                    
                    TextField("Exemplo : Desenvolvendo projeto java ", text: $inputTitle.value)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    Text("Data")
                        .font(Font.system(size: 16, weight:.bold))
                    
                    DatePicker("Tarefa iniciada em: ", selection: $dataSelecionada)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    VStack{
                        HStack{
                            Text("Detalhes")
                                .font(Font.system(size: 16, weight:.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                            Text("\(self.wordCount) Caracteres")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.headline)
                                .foregroundColor(.secondary)
                            //.padding(.trailing)
                        }
                        TextEditor(text: $inputDescription.value)
                            .cornerRadius(6)
                            .font(.body)
                            
                            .onChange(of: inputDescription.value , perform: { value in
                                let words = value.count
                                self.wordCount = words
                            })
                    }
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
            title = inputTitle.value
            description = inputDescription.value
            date =  dateFormatte.string(from: self.dataSelecionada)
            
            if title != "" && description != "" {
                let parameters: [String: Any] = ["title" : title, "description":description, "date":dateFormatte.string(from: self.dataSelecionada)]
                viewwModel.createPost(parameters: parameters)
                viewwModel.fetchPost()
                isPresented.toggle()
            }else {
                isAlert.toggle()
            }
        }, label: {
            Text("Adicionar")
        })
    }
}
