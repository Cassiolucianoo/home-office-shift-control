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
    @State private var mostrarData = false
    
    var body: some View {
        
        NavigationView{
            
            VStack(spacing: 15){
                
                Text("Finalizar tarefa")
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
                
                    .padding(20)
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
            
                .navigationBarTitle("Criar tarefa", displayMode: .inline)
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
                .foregroundColor(.black)
                .font(.system(size: 25))
        })
    }
    
    var trailing: some View{
        Button(action: {
            
            
        }, label: {
            Image(systemName: "doc.fill.badge.plus")
                .foregroundColor(.black)
                .font(.system(size: 25))
        })
    }
    
}

//struct CustomToggleStyle: ToggleStyle {
//    @State private var vibrateOnRing = false
//    func makeBody(configuration: Configuration) -> some View {
//        Button(action: {
//
//            configuration.isOn.toggle()
//            vibrateOnRing = false
//
//        }) {
//
//            HStack {
//
//                Toggle(isOn: $vibrateOnRing) {
//
//                }
//
//                Text(configuration.isOn ? "Finalizar tarefa" : "Tarefa finalizada")
//                    .bold()
//            }
//        }
//        .foregroundColor(configuration.isOn ? .black : .gray) // Defina as cores desejadas para o texto quando ativado e desativado
//    }
//}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(  )
    }
}
