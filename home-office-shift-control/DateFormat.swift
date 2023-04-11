//
//  DataFormatter.swift
//  home-office-shift-control
//
//  Created by cassio on 03/04/23.
//

import Foundation

var formate: DateFormatter {
   let dateFormatter = DateFormatter()
   //dateFormatter.dateFormat = "dd/ MM/ YYYY HH:mm:ss"
   dateFormatter.dateFormat = "dd/ MM/ YYYY HH:mm"
   return dateFormatter
}
