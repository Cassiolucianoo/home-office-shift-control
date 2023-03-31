//
//  home_office_shift_controlApp.swift
//  home-office-shift-control
//
//  Created by cassio on 25/03/23.
//

import SwiftUI

@main
struct home_office_shift_controlApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel())
        }
    }
}
