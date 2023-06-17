//
//  AlertType.swift
//  home-office-shift-control
//
//  Created by cassio on 16/06/23.
//

import SwiftUI

enum AlertType: Identifiable {
    case none
    case emptyFields
    case addError
    
    var id: Int {
        // Retorna um valor único para cada caso da enumeração
        switch self {
        case .none:
            return 0
        case .emptyFields:
            return 1
        case .addError:
            return 2
        }
    }
    
    var alertItem: AlertItem? {
        switch self {
        case .emptyFields:
            return AlertItem(
                title: Text("CAMPOS EM BRANCO"),
                message: Text("Todos os campos são obrigatórios!"),
                dismissButton: nil
            )
        case .addError:
            return AlertItem(
                title: Text("Erro ao adicionar dados"),
                message: Text("Não foi possível conectar ao servidor. Verifique sua conexão com a internet e tente novamente."),
                dismissButton: .default(Text("OK"))
            )
        case .none:
            return nil
        }
    }
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text?
    let dismissButton: Alert.Button?
}
