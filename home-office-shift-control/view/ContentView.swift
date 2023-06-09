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

    
    let fruits = ["Apple", "Banana", "Orange"]
    
    
    var body: some View {
        
        NavigationView{
            List {
                 ForEach(viewModel.items, id: \.id){ item in
               // ForEach(fruits, id: \.self) { fruit in
                    
                    // NavigationLink(destination: DetailView(),
                    //label: {
                    
                    Button(action: {
                        selectedItem = item

                        isDetailViewPresented = true
                        print("Botão selecionado")
                    }) {

                        HStack{
                            HStack{
                                VStack(spacing: 30){
                                    HStack {
                                        Image(systemName: "checkmark.circle")
                                            .font(.system(size: 25))
                                            .frame(width: 25, height: 25)
                                            .padding(.leading, 10)
                                        
                                         Text(item.title)
                                        
                                       Text("Titulo 1")
                                            .font(.callout)
                                            .bold()
                                            .lineLimit(1)
                                        //.foregroundColor(.green)
                                        Spacer()
                                        
                                    }
                                    HStack {
                                        
                                        Text(item.description)
                                        
                                        
                                       Text("Texto de descrição da tarefa")
                                            .font(.system(size: 12))
                                            .lineLimit(7)
                                        Spacer()
                                    }
                                    
                                     Text(item.date)
                                    
                                    
                                    Text("Data: 21 / 09 / 1988")
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
                   
                    .sheet(isPresented: $isDetailViewPresented) {
                        if let item = selectedItem {
                            DetailView(item: item)
                        }
                    }
                }
                .onDelete(perform: deletePost)
                
            }
            .listStyle(InsetListStyle())
                .navigationBarTitle("Tarefas")
                .navigationBarItems(trailing: plusButton)
        }
       
        .sheet(isPresented: $isPresentedNewPost, content: {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//NavigationView{
//    List {
//         ForEach(viewModel.items, id: \.id){ item in
//       // ForEach(fruits, id: \.self) { fruit in
//
//            // NavigationLink(destination: DetailView(),
//            //label: {
//
//            Button(action: {
//               //positionItem = item
//                //frutaEditada = frutas[fruta]
//                //editando = true
//               // isPresentedNewPost.toggle()
//                DetailView()
//                print("Botão selecionado")
//            }) {
//
//                HStack{
//                    HStack{
//                        VStack(spacing: 30){
//                            HStack {
//                                Image(systemName: "checkmark.circle")
//                                    .font(.system(size: 25))
//                                    .frame(width: 25, height: 25)
//                                    .padding(.leading, 10)
//
