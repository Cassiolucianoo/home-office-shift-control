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
        @State  var post = ""
        
        var body: some View {
            
            NavigationView{
                List {
                    ForEach(viewModel.items, id: \.id){ item in
                        
                        NavigationLink(
                            
                            destination: DetailView(item: item),
                            label: {
                                VStack(alignment: .leading){
                                    Text(item.title)
                                    Text(item.post)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                            }
                        )
                    }.onDelete(perform: deletePost)
                    
                    
                }.listStyle(InsetListStyle())
                .navigationBarTitle("Tarefas")
                .navigationBarItems(trailing: plusButton)
            }.sheet(isPresented: $isPresentedNewPost, content: {
                NewPostView(title: $title, post: $post, isPresented: $isPresentedNewPost)
                
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
                post = ""
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
