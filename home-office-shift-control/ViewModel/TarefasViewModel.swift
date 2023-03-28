//
//  UsersViewModel.swift
//  home-office-shift-control
//
//  Created by cassio on 27/03/23.
//

import Foundation


final class TarefasViewModel: ObservableObject {
    @Published var hasError = false
    @Published var error: TarefasError?
    @Published private(set) var isRefreshing = false
    

   @Published var tarefas: [Tarefa] = []

    func fetchTarefas() {
        
        let usersUrlString = "http://localhost:3000/tarefas"
        if let url = URL(string: usersUrlString){
            
            URLSession
                .shared
                .dataTask(with: url){ data, response, error in
                    
                    
                    DispatchQueue.main.async {
                        
                        defer {
                            self.isRefreshing = false
                        }
                        
                        //TODO: handle retunrning data on the Main thread
                        
                        if let error = error{
                            //TODO: handle error
                            self.hasError = true
                            self.error = TarefasError.custom(error: error)
                            
                        }else {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle proprerties that look like first_name > firstName
                            
                            if let data = data,
                               let tarefas = try? decoder.decode([Tarefa].self, from: data){
                                //TODO: Handle setting the data
                                
                                self.tarefas = tarefas
                                
                            } else {
                                
                                //TODO: Handle error
                                self.hasError = true
                                self.error = TarefasError.failedToDecode
                            }
                        }
                        
                    }
                    
                    
                    
                }.resume()
            
        }
    }
}

extension TarefasViewModel {
    enum TarefasError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}

