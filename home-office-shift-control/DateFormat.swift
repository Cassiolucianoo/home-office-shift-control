//
//  DataFormatter.swift
//  home-office-shift-control
//
//  Created by cassio on 03/04/23.
//

import Foundation

var formate: DateFormatter {
   let dateFormatter = DateFormatter()
   dateFormatter.dateFormat = "dd-mm-yy HH:mm:ss"
   return dateFormatter
}
