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
                        
                        NavigationLink(destination: DetailView(item: item),
                                       label: {
                                        
                                        HStack{
                                            HStack{
                                                VStack(spacing: 30){
                                                    HStack {
                                                        Image(systemName: "checkmark.circle")
                                                            .foregroundColor(.white)
                                                            .font(.system(size: 25))
                                                            .frame(width: 25, height: 25)
                                                            .background(Circle().fill(Color.green))
                                                            .padding(.leading, 10)
                                                        Text(item.title)
                                                            .font(.callout)
                                                            .bold()
                                                            .lineLimit(1)
                                                            .foregroundColor(.green)
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
                                            .background(Rectangle().fill(Color.white))
                                            .cornerRadius(10)
                                            .shadow(color: .gray, radius: 3, x: 2, y: 2)
                                            
                                        }
                                        
                                       }
                        )
                    }
                    .onDelete(perform: deletePost)
                    .shadow(color: .gray, radius: 3, x: 2, y: 2)
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
                Image(systemName: "plus.circle.fill")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            })
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
