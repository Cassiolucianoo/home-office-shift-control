//
//  ViewModel.swift
//  home-office-shift-control
//
//  Created by cassio on 28/03/23.
//


import Alamofire
import Foundation

class ViewModel: ObservableObject {
    @Published var items = [PostModel]()
    
    let prefixUrl = "http://localhost:3000"
    
  
    
    init() {
        fetchPost()
    }
    
    //MARK: - Fetch Data
    func fetchPost() {
        guard let url = URL(string: "\(prefixUrl)/posts") else {
            print("URL não encontrada")
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: [PostModel].self, decoder: JSONDecoder()) { [weak self] response in
                switch response.result {
                case .success(let result):
                    DispatchQueue.main.async {
                        self?.items = result
                    }
                case .failure(let error):
                    print("Erro ao recuperar dados: POST", error.localizedDescription)
                }
            }
    }
    
    
    //MARK: - Create Data
    func createPost(parameters: [String: Any]) {
        guard let url = URL(string: "\(prefixUrl)/posts") else {
            print("URL não encontrada")
            return
        }
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: PostModel.self, decoder: JSONDecoder()) { [weak self] response in
                switch response.result {
                case .success(let result):
                    DispatchQueue.main.async {
                        self?.items.append(result)
                    }
                case .failure(let error):
                    print("Erro ao criar post: CREATE", error.localizedDescription)
                }
            }
    }
    
    //MARK: - Update Data
    func updatePost(parameters: [String: Any], id: Int) {
        guard let url = URL(string: "\(prefixUrl)/posts/\(id)") else {
            print("URL não encontrada")
            return
        }
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: PostModel.self, decoder: JSONDecoder()) { [weak self] response in
                switch response.result {
                case .success(let result):
                    DispatchQueue.main.async {
                        if let index = self?.items.firstIndex(where: { $0.id == id }) {
                            self?.items[index] = result
                        }
                    }
                case .failure(let error):
                    print("Erro ao atualizar post: UPDATE", error.localizedDescription)
                }
            }
    }
    
    //MARK: - Delete Data
    func deletePost(id: Int) {
        guard let url = URL(string: "\(prefixUrl)/posts/\(id)") else {
            print("URL não encontrada")
            return
        }
        
        AF.request(url, method: .delete)
            .validate()
            .responseData { [weak self] response in
                switch response.result {
                case .success:
                    DispatchQueue.main.async {
                        self?.items.removeAll(where: { $0.id == id })
                    }
                case .failure(let error):
                    print("Erro ao excluir post: DELETE", error.localizedDescription)
                }
            }
    }
}



//import Alamofire
//import Foundation
//
//class ViewModel: ObservableObject {
//    @Published var items = [PostModel]()
//
//    let prefixUrl = "http://localhost:3000"
//
//    private static let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM/yyyy HH:mm"
//        return formatter
//    }()
//
//    init() {
//        fetchPost()
//    }
//
//    //MARK: - Fetch Data
//    func fetchPost() {
//        guard let url = URL(string: "\(prefixUrl)/posts") else {
//            print("URL não encontrada")
//            return
//        }
//
//        AF.request(url)
//            .responseData { [weak self] response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let decoder = JSONDecoder()
//                        decoder.dateDecodingStrategy = .formatted(ViewModel.dateFormatter)
//                        let result = try decoder.decode([PostModel].self, from: data)
//                        DispatchQueue.main.async {
//                            self?.items = result
//                        }
//                    } catch {
//                        print("Erro ao decodificar os dados: POST", error.localizedDescription)
//                    }
//                case .failure(let error):
//                    print("Erro ao recuperar dados: POST", error.localizedDescription)
//                }
//            }
//    }
//
//
//    //MARK: - Create Data
//    func createPost(parameters: [String: Any]) {
//        guard let url = URL(string: "\(prefixUrl)/posts") else {
//            print("URL não encontrada")
//            return
//        }
//
//        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseData { [weak self] response in
//                switch response.result {
//                case .success(let data):
//                    if let jsonString = String(data: data, encoding: .utf8) {
//                        print("Response JSON: \(jsonString)")
//                    }
//                    do {
//                        let decoder = JSONDecoder()
//                        decoder.dateDecodingStrategy = .formatted(ViewModel.dateFormatter)
//                        let result = try decoder.decode(PostModel.self, from: data)
//                        DispatchQueue.main.async {
//                            self?.items.append(result)
//                        }
//                    } catch {
//                        print("Erro ao decodificar os dados: CREATE", error.localizedDescription)
//                    }
//                case .failure(let error):
//                    print("Erro ao criar post: CREATE", error.localizedDescription)
//                }
//            }
//    }
//
//    //MARK: - Update Data
//    func updatePost(parameters: [String: Any], id: Int) {
//        guard let url = URL(string: "\(prefixUrl)/posts/\(id)") else {
//            print("URL não encontrada")
//            return
//        }
//
//        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default)
//            .responseData { [weak self] response in
//                switch response.result {
//                case .success(let data):
//                    if let jsonString = String(data: data, encoding: .utf8) {
//                        print("Response JSON: \(jsonString)")
//                    }
//                    do {
//                        let decoder = JSONDecoder()
//                        decoder.dateDecodingStrategy = .formatted(ViewModel.dateFormatter)
//                        let result = try decoder.decode(PostModel.self, from: data)
//                        DispatchQueue.main.async {
//                            if let index = self?.items.firstIndex(where: { $0.id == id }) {
//                                self?.items[index] = result
//                            }
//                        }
//                    } catch {
//                        print("Erro ao decodificar os dados: UPDATE", error.localizedDescription)
//                    }
//                case .failure(let error):
//                    print("Erro ao atualizar post: UPDATE", error.localizedDescription)
//                }
//            }
//    }
//
//    //MARK: - Delete Data
//    func deletePost(id: Int) {
//        guard let url = URL(string: "\(prefixUrl)/posts/\(id)") else {
//            print("URL não encontrada")
//            return
//        }
//
//        AF.request(url, method: .delete)
//            .responseData { [weak self] response in
//                switch response.result {
//                case .success:
//                    DispatchQueue.main.async {
//                        self?.items.removeAll(where: { $0.id == id })
//                    }
//                case .failure(let error):
//                    print("Erro ao excluir post: DELETE", error.localizedDescription)
//                }
//            }
//    }
//}








// antiga forma que fiz a chamada dos dados da api

//import Foundation
//
////CREATE
//// METHOD: POST
//// http://localhost:3000/postTarefa
//
//class  ViewModel: ObservableObject {
//
//    @Published var items = [PostModel]()
//
//    let prefixUrl = "http://localhost:3000"
//
//    init() {
//        fetchPost()
//    }
//
//    //MARK: - recuperar DATA ------------------------------------------------------------------
//    func fetchPost() {
//        guard let url = URL(string: "\(prefixUrl)/posts") else {
//            print("Recupera error :  URL não encontrada")
//            return
//        }
//        URLSession.shared.dataTask(with: url){ (data, res, error)in
//            if error != nil {
//                print(" Recupera error fetch json error:  URL não encontrada ------------------------------------------------------------------ 2", error?.localizedDescription ?? "")
//
//                return
//            }
//
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode([PostModel].self, from: data)
//                    DispatchQueue.main.async {
//                        self.items = result
//                    }
//                } else {
//                    print("Recupera error: No data")
//                }
//            } catch let jsonError {
//                print("Recupera error fetch json error:", jsonError.localizedDescription)
//                print("Recupera Os dados não puderam ser lidos porque não estão no formato correto.:", jsonError.localizedDescription)
//            }
//
//        }.resume()
//    }
//
//
//
//
//    //MARK: - Create DATA ------------------------------------------------------------------
//    func createPost(parameters: [String: Any]) {
//        guard let url = URL(string: "\(prefixUrl)/posts") else {
//            print("URL não encontrada")
//            return
//        }
//
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = data
//        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
//
//
//        URLSession.shared.dataTask(with: request){ (data, res, error)in
//            if error != nil {
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
//
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode(DataModel.self, from: data)
//                    DispatchQueue.main.async {
//                        print(result)
//                    }
//                }else {
//
//                    print("No data")
//
//                }
//
//            }catch let JsonError {
//                print("fetch json error: ", JsonError.localizedDescription)
//            }
//        }.resume()
//    }
//
//    //MARK: - Update DATA ----------------------
//    func updatePost(parameters: [String: Any], id: Int ) {
//
//
//
//        guard let url = URL(string: "\(prefixUrl)/posts/\(id)") else {
//            print("URL não encontrada\(id)")
//            return
//        }
//
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.httpBody = data
//        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
//
//
//        URLSession.shared.dataTask(with: request){ (data, res, error)in
//            if error != nil {
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
//
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode(DataModel.self, from: data)
//                    DispatchQueue.main.async {
//                        print(result)
//                    }
//                }else {
//
//                    print("No data")
//
//                }
//
//            }catch let JsonError {
//                print("fetch json error: ", JsonError.localizedDescription)
//            }
//        }.resume()
//    }
//
//
//    //MARK: - delete DATA ----------------------------------------------------------------------------------------
//    func deletePost(parameters: [String: Any], id : Int ) {
//
//
//
//        guard let url = URL(string: "\(prefixUrl)/posts/\(id)") else {
//            print("URL não encontrada\(id)")
//            return
//        }
//
//        let data = try! JSONSerialization.data(withJSONObject: parameters)
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        request.httpBody = data
//        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
//
//
//        URLSession.shared.dataTask(with: request){ (data, res, error)in
//            if error != nil {
//                print("error", error?.localizedDescription ?? "")
//                return
//            }
//
//            do {
//                if let data = data {
//                    let result = try JSONDecoder().decode([PostModel].self, from: data)
//                    DispatchQueue.main.async {
//                        print(result)
//                    }
//                }else {
//
//                    print("No data")
//
//                }
//
//            }catch let JsonError {
//                print("fetch json error: ", JsonError.localizedDescription)
//            }
//        }.resume()
//    }
//}
