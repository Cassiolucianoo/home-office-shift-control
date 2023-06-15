//
//  HideKeyboard.swift
//  home-office-shift-control
//
//  Created by cassio on 15/06/23.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
