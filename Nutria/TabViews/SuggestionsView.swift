//
//  SuggestionsView.swift
//  Nutria
//
//  Created by Jones Mays II on 4/28/24.
//

import SwiftUI

struct SuggestionsView: View {
    
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
            
            VStack(spacing: UIScreen.screenWidth/15){
                
                ZStack(){
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: UIScreen.screenWidth/1.25 , height: UIScreen.screenHeight/3)
                        .cornerRadius(15)
                        .padding(.top)
                        .overlay(){
                            
                            Circle()
                                .stroke(lineWidth: 15)
                                .foregroundColor(Color.darkGreen)
                                .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenWidth/2)
                            
                        }
                    
                
                }
                .overlay(){
                    
                    ZStack(){
                        Text("X%")
                        
                        VStack(){
                            
                            Spacer()
                            
                            Text("Reduction in pesticide usage")
                                .font(.system(size: UIScreen.screenWidth/20, weight: .light, design: .default))
                                .padding(.bottom)
                                
                        }
                    }
             
                }
                
                HStack(){
                    
                    Text("Suggestions")
                        .font(.system(size: UIScreen.screenWidth/20, weight: .bold, design: .default))
                        .lineLimit(1)
                        .padding(.leading)
                    
                    Spacer()
                }
                
                ScrollView(showsIndicators: false){
                   
                    VStack(spacing: UIScreen.screenWidth/15){
                        
                        ForEach(0..<userDataService.suggestions.count) { index in
                            
                            VStack(){
                                
                                Text(userDataService.suggestions[index].name)
                                    .padding()
                                
                                Text(userDataService.suggestions[index].info)
                                    .padding(.bottom)
                                    .padding(.horizontal)
                            }
                            .frame(width: UIScreen.screenWidth/1.25)
                            .background(Color.lightGray)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                                
                        }
                    }
                }
                
                Spacer()
                
            }
        }
    }

}
