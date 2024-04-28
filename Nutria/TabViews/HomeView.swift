//
//  HomeView.swift
//  Nutria
//
//  Created by Jones Mays II on 4/28/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var userDataService: UserDataService
    @State private var animateGradient: Bool = false
    
    var body: some View {
      
        ZStack(){
            
            VStack(spacing:0){
                
                LinearGradient(colors: [Color.lightGreen, Color.darkGreen], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .onAppear {
                        DispatchQueue.main.async {
                            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                                animateGradient.toggle()
                            }
                        }
                    }
                    .frame(height: UIScreen.screenHeight/4)
                
                Rectangle()
                    .fill(Color.extraLightGray)
                    .edgesIgnoringSafeArea([.top, .leading, .trailing])
                
            }
            
            ScrollView(showsIndicators: false){
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/3)
                    .cornerRadius(15)
                    .padding(.top)
                
            }
        }
    }

}

