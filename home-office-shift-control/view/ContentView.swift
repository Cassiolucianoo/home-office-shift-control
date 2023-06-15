//
//  ContentView.swift
//  home-office-shift-control
//
//  Created by cassio on 25/03/23.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresentedNewPost = false
    @State private var selectedItem: PostModel? = nil
    @State private var title = ""
    @State private var description = ""
    @State private var date = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items, id: \.id) { item in
                    Button(action: {
                        selectedItem = item
                        print("Botão selecionado")
                    }) {
                        HStack {
                            VStack(spacing: 20) {
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
                            .padding()
                            .background(Color(UIColor.secondarySystemGroupedBackground))
                            .background(Rectangle().fill(Color.black))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                        }
                    }
                }
                .onDelete(perform: deletePost)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Tarefas")
            .navigationBarItems(trailing: plusButton)
        }
        .onAppear {
            viewModel.fetchPost()
            print("recarega a view")
        }
        .sheet(item: $selectedItem) { selectedItem in
            DetailView(item: selectedItem)
        }
        .fullScreenCover(isPresented: $isPresentedNewPost) {
            NewPostView(title: $title, description: $description, date: $date, isPresented: $isPresentedNewPost)
        }
    }

    private func deletePost(indexSet: IndexSet) {
        if let firstIndex = indexSet.first {
            let id = viewModel.items[firstIndex].id
            viewModel.deletePost(id: id)
            viewModel.fetchPost()
            print("Item excluído com sucesso")
        }
    }

    var plusButton: some View {
        Button(action: {
            isPresentedNewPost.toggle()
            title = ""
            description = ""
            print(" + precionado")
        }) {
            ZStack {
                Image("add")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                Text("Novo")
                    .foregroundColor(.black)
                    .font(.system(size: 12))
                    .offset(x: 0, y: 20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
