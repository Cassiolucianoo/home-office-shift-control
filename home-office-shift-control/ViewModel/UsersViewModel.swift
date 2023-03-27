//
//  UsersViewModel.swift
//  home-office-shift-control
//
//  Created by cassio on 27/03/23.
//

import Foundation


final class UsersViewModel: ObservableObject {
    
    @Published var users: [Tarefa] = []
    
    func fetchUsers() {
        
        let usersUrlString = "http://localhost:3000/tarefas"
        if let url = URL(string: usersUrlString){
            
            URLSession
                .shared
                .dataTask(with: url){ data, response, error in
                    
                    //TODO: handle retunrning data on the Main thread
                    
                    if let error = error{
                        //TODO: handle error
                        
                    }else {
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase // Handle proprerties that look like first_name > firstName
                        
                        if let data = data,
                           let users = try? decoder.decode([Tarefa].self, from: data){
                            //TODO: Handle setting the data
                            
                            self.users = users
                            
                        } else {
                            
                            //TODO: Handle error
                            
                        }
                    }
                }.resume()
            
        }
    }
}
