//
//  ContentView.swift
//  home-office-shift-control
//
//  Created by cassio on 25/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresentedNewPost = false
    @State var isDetailViewPresented = false
    @State var title = ""
    @State var description = ""
    @State var tempo = ""
    @State var date = ""
    @State private var selectedItem: PostModel? = nil

    var body: some View {
        
        NavigationView{
            List {
                 ForEach(viewModel.items, id: \.id){ item in
        
                    Button(action: {
                        selectedItem = item

                        isDetailViewPresented = true
                        print("Botão selecionado")
                    }) {

                        HStack{
                            HStack{
                                VStack(spacing: 20){
                                    HStack {
                                        Image(systemName: "checkmark.circle")
                                            .font(.system(size: 25))
                                            .frame(width: 25, height: 25)
                                            .padding(.leading, 10)
                                         Text(item.title)
                                            .font(.callout)
                                            .bold()
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                    HStack {
                                        Text(item.description)
                                            .font(.system(size: 12))
                                            .lineLimit(7)
                                        Spacer()
                                    }
                                     Text(item.date)
                                        .font(.caption)
                                        .lineLimit(1)
                                }
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .background(Rectangle().fill(Color.black))
                            
                            .cornerRadius(10) // Define o raio do canto arredondado
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2) // Define a cor e a largura da linha
                            )
                        }

                    }
                   
                }
                .onDelete(perform: deletePost)
                
            }
            .listStyle(InsetListStyle())
                .navigationBarTitle("Tarefas")
                .navigationBarItems(trailing: plusButton)
        }
        .onAppear {
                   viewModel.fetchPost() // Chama a função para buscar os dados dos posts
               }
        .sheet(item: $selectedItem) { item in
            DetailView(title: $title, description: $description, item: item)
       
        }
       
        .fullScreenCover(isPresented: $isPresentedNewPost, content: {
            NewPostView(title: $title, description: $description, date: $date, isPresented: $isPresentedNewPost)
            
            
        })
    }
    
    private func deletePost(indexSet: IndexSet) {
        if let firstIndex = indexSet.first {
            let id = viewModel.items[firstIndex].id
            
            DispatchQueue.main.async {
                let parameters: [String: Any] = ["id": id]
                self.viewModel.deletePost(parameters: parameters, id: id)
                self.viewModel.fetchPost()
                print("Item excluído com sucesso")
            }
        }
    }

    var plusButton:  some View{
        Button(action: {
            
            isPresentedNewPost.toggle()
            title = ""
            description = ""
            print(" + precionado")
        }, label: {
            Image(systemName: "plus.circle.fill")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
