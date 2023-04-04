//
//  ContentView.swift
//  home-office-shift-control
//
//  Created by cassio on 25/03/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
    
    struct HomeView : View{
        @EnvironmentObject var viewModel: ViewModel
        @State var isPresentedNewPost = false
        @State var title = ""
        @State var description = ""
        @State var tempo = ""
        @State var date = ""
        
        var body: some View {
            
            NavigationView{
                List {
                    ForEach(viewModel.items, id: \.id){ item in
                        
                        NavigationLink(
                            
                            destination: DetailView(item: item),
                            label: {
                                VStack(alignment: .leading){
                                    Text(item.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    
                                    Text(item.description)
                                        .fontWeight(.bold)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                        .fontWeight(.bold)
                                        
                                        .frame(minWidth: 75, idealWidth: 75, maxWidth: .infinity, minHeight: 75, idealHeight: 75, maxHeight: .infinity, alignment: .center)
                                        .padding(.horizontal)
                                    // .border(Color.gray.opacity(0.5))
                                    
                                    HStack(alignment: .center){
                                        Text("DATA: \(item.date) ")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .multilineTextAlignment(.center)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        //.background(Color.gray.opacity(0.1))
                                    }
                                }
                                
                            }
                        )
                        
                    }
                    .onDelete(perform: deletePost)
                    .background(Color.gray .opacity(0.1))
                    .cornerRadius(10)
                    
                }.listStyle(InsetListStyle())
                .navigationBarTitle("Tarefas")
                .navigationBarItems(trailing: plusButton)
            }.sheet(isPresented: $isPresentedNewPost, content: {
                NewPostView(title: $title, description: $description, date: $date, isPresented: $isPresentedNewPost)
                
            })
        }
        
        private func deletePost(indexSet: IndexSet){
            let id =  indexSet.map {viewModel.items[$0].id}
            DispatchQueue.main.async {
                
                let ids = id[0]
                let parameters: [String: Any] = ["id": id[0]]
                self.viewModel.deletePost(parameters: parameters, id : ids)
                self.viewModel.fetchPost()
                print("Id enviado para api \(ids)")
            }
        }
        
        var plusButton:  some View{
            Button(action: {
                isPresentedNewPost.toggle()
                title = ""
                description = ""
                print(" + precionado")
            }, label: {
                Image(systemName: "plus")
            })
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




