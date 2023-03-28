//
//  ViewModel.swift
//  home-office-shift-control
//
//  Created by cassio on 28/03/23.
//

import Foundation
import SwiftUI

//CREATE
// METHOD: POST
// http://localhost:3000/postTarefa

class  ViewModel: ObservableObject {
    @Published var items = [PostTarefa]()
    let prefixUrl = "http://localhost:3000"
    
    init() {
        fetchPost()
    }
    
    //MARK: - recuperar DATA ----------------------
    func fetchPost() {
        guard let url = URL(string: "\(prefixUrl)/posts") else {
            print("URL não encontrada")
            return
        }
        URLSession.shared.dataTask(with: url){ (data, res, error)in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(Tarefa.self, from: data)
                    DispatchQueue.main.async {
                        self.items = result.data
                    }
                }else {
                    
                    print("No data")
                    
                }
                
            }catch let JsonError {
                print("fetch json error: ", JsonError.localizedDescription)
            }
        }.resume()
    }
    
    //MARK: - Create DATA ----------------------
    func createPost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/createTarefa") else {
            print("URL não encontrada")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        
        
        URLSession.shared.dataTask(with: request){ (data, res, error)in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(Tarefa.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                }else {
                    
                    print("No data")
                    
                }
                
            }catch let JsonError {
                print("fetch json error: ", JsonError.localizedDescription)
            }
        }.resume()
    }
    
    //MARK: - Update DATA ----------------------
    func updatePost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/updatePost") else {
            print("URL não encontrada")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        
        
        URLSession.shared.dataTask(with: request){ (data, res, error)in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(Tarefa.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                }else {
                    
                    print("No data")
                    
                }
                
            }catch let JsonError {
                print("fetch json error: ", JsonError.localizedDescription)
            }
        }.resume()
    }
    
    //MARK: - delete DATA ----------------------
    func deletePost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/deletePost") else {
            print("URL não encontrada")
            return
        }
        
        let data = try! JSONSerialization.data(withJSONObject: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        
        
        URLSession.shared.dataTask(with: request){ (data, res, error)in
            if error != nil {
                print("error", error?.localizedDescription ?? "")
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(Tarefa.self, from: data)
                    DispatchQueue.main.async {
                        print(result)
                    }
                }else {
                    
                    print("No data")
                    
                }
                
            }catch let JsonError {
                print("fetch json error: ", JsonError.localizedDescription)
            }
        }.resume()
    }
}
