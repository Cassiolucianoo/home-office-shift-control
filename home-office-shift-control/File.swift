//
//  File.swift
//  home-office-shift-control
//
//  Created by cassio on 10/04/23.
//

import SwiftUI
import Foundation

extension View {
    func hideKeybord(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
