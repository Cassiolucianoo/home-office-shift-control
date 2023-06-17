import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var isPresentedNewPost = false
    @State private var selectedItem: PostModel? = nil
    @State private var title = ""
    @State private var description = ""
    @State private var date = ""
    @State private var showSplash = true

    @State private var isErrorFetchingData = false // Estado para verificar a conexão com a internet
    @State private var showErrorAlert = false // Estado para controlar a exibição do alerta de erro

    var body: some View {

        if showSplash {
            SplashScreenView()
                .onAppear {
                    // Defina um atraso para encerrar a tela de splash após alguns segundos
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showSplash = false
                        fetchPosts() // Faça a chamada para buscar os dados quando a tela de splash for encerrada
                    }
                }
        } else {
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
            .sheet(item: $selectedItem) { selectedItem in
                DetailView(item: selectedItem)
            }
            .fullScreenCover(isPresented: $isPresentedNewPost) {
                NewPostView(title: $title, description: $description, date: $date, isPresented: $isPresentedNewPost)
            }.onAppear {
                
               // fetchPosts()
            
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Erro ao recuperar dados"),
                    message: Text("Não foi possível conectar ao servidor. Verifique sua conexão com a internet e tente novamente."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    private func fetchPosts() {
        viewModel.fetchPosts { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.isErrorFetchingData = false
                    print("*********     Dados recuperados com sucesso    **********")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isErrorFetchingData = true
                    print("Erro ao recuperar dados: POST", error.localizedDescription)
                    self.showErrorAlert = true
                }
            }
        }
    }

    private func deletePost(indexSet: IndexSet) {
        if let firstIndex = indexSet.first {
            let id = viewModel.items[firstIndex].id
            viewModel.deletePost(id: id)
            print("Item excluído com sucesso")
        }
    }

    var plusButton: some View {
        Button(action: {
            isPresentedNewPost.toggle()
            title = ""
            description = ""
            print(" + pressionado")
        }) {
            ZStack {
                Image("add")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .padding(.bottom, 15)
                Text("Novo")
                    .foregroundColor(.black)
                    .font(.system(size: 12))
                    .offset(x: 0, y: 20)
                    .padding(.bottom, 12)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
