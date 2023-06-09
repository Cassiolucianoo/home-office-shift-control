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
    
    @Published var items = [PostModel]()
    
    let prefixUrl = "http://localhost:3000"
    
    init() {
        fetchPost()
    }
    
    //MARK: - recuperar DATA ------------------------------------------------------------------
    func fetchPost() {
        guard let url = URL(string: "\(prefixUrl)/posts") else {
            print("Recupera error :  URL não encontrada")
            return
        }
        URLSession.shared.dataTask(with: url){ (data, res, error)in
            if error != nil {
                print(" Recupera error fetch json error:  URL não encontrada ------------------------------------------------------------------ 2", error?.localizedDescription ?? "")
               
                return
            }
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([PostModel].self, from: data)
                    DispatchQueue.main.async {
                        self.items = result
                    }
                } else {
                    print("Recupera error: No data")
                }
            } catch let jsonError {
                print("Recupera error fetch json error:", jsonError.localizedDescription)
                print("Recupera Os dados não puderam ser lidos porque não estão no formato correto.:", jsonError.localizedDescription)
            }

        }.resume()
    }
    
    
    
    
    //MARK: - Create DATA ------------------------------------------------------------------
    func createPost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/posts") else {
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
                    let result = try JSONDecoder().decode(DataModel.self, from: data)
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
    func updatePost<T: Encodable>(parameters: [String: T], id: Int) {
        guard let url = URL(string: "\(prefixUrl)/posts/\(id)") else {
            print("URL não encontrada: \(id)")
            return
        }
        
        do {
            let jsonData = try JSONEncoder().encode(parameters)
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Erro ao atualizar o post:", error.localizedDescription)
                    return
                }
                
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(DataModel.self, from: data)
                        DispatchQueue.main.async {
                            print(result)
                        }
                    } catch {
                        print("Erro ao decodificar a resposta:", error.localizedDescription)
                    }
                } else {
                    print("Nenhum dado retornado")
                }
            }.resume()
        } catch {
            print("Erro ao codificar os parâmetros:", error.localizedDescription)
        }
    }

    
    //MARK: - delete DATA ----------------------------------------------------------------------------------------
    func deletePost(parameters: [String: Any], id : Int ) {
        
        
        
        guard let url = URL(string: "\(prefixUrl)/posts/\(id)") else {
            print("URL não encontrada\(id)")
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
                    let result = try JSONDecoder().decode([PostModel].self, from: data)
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
