//
//  Splashscreen.swift
//  home-office-shift-control
//
//  Created by cassio on 15/06/23.
//

import SwiftUI
struct SplashScreenView: View {
    @State private var progress: Float = 0.0
    var body: some View {
        VStack {
            Text("Agenda do DEV")
                .bold()
                .multilineTextAlignment(.center)
                                        
                .font(.title)
            
            Image("logo")
                .resizable()
                .frame(width: 130,height: 130)
            
            ProgressView(value: progress)
                .onAppear {
                    // Defina um atraso para encerrar a tela de splash após alguns segundos
                    startProgress()
                }
                .accentColor(.black) // Define a cor da barra de progresso
                             .frame(width: 150)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("paper1") // Substitua "background" pelo nome da sua imagem de fundo
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        )
        // Personalize o layout e o estilo conforme necessário
    }
    func startProgress() {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                progress += 0.1
                if progress >= 1.0 {
                    timer.invalidate()
                }
            }
        }
}

