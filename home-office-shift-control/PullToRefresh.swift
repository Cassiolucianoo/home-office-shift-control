//
//  PullToRefresh.swift
//  home-office-shift-control
//
//  Created by cassio on 13/06/23.
//

import SwiftUI

struct PullToRefresh: View {
    @Binding var isRefreshing: Bool
    var onRefresh: () -> Void

    var body: some View {
        if isRefreshing {
            VStack {
                Spacer()
                Text("Atualizando")
                    .bold()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground).opacity(0.6)) // Define a cor de fundo transparente
                        .onAppear(perform: onRefresh)
                        .allowsHitTesting(false)
                    }
        }
    }




