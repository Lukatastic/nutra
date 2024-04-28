//
//  ContentView.swift
//  Nutria
//
//  Created by Jones Mays II on 4/27/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animateGradient: Bool = false
    @State private var questionText: String = "What is your name?"
    @State private var farmSize: Double = 0
    @State private var tapCount: Int = 0
    
    @State private var potatoesForegroundColor = Color.darkGreen
    @State private var maizeForegroundColor = Color.darkGreen
    @State private var wheatForegroundColor = Color.darkGreen
    @State private var riceForegroundColor = Color.darkGreen
    @State private var soybeanForegroundColor = Color.darkGreen

    @State private var potatoesBackgroundColor = Color.white
    @State private var maizeBackgroundColor = Color.white
    @State private var wheatBackgroundColor = Color.white
    @State private var riceBackgroundColor = Color.white
    @State private var soybeanBackgroundColor = Color.white
    
    @StateObject public var userDataService: UserDataService

    var body: some View {
        
        ZStack(){
            
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
            
            VStack(){
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: UIScreen.screenWidth/1.2 ,height: UIScreen.screenHeight/1.5)
                    .cornerRadius(10)
                    .overlay(){
                        
                        VStack(alignment: .center){
                            
                            Text("Lets get started!")
                                .font(.system(size:  UIScreen.screenWidth/11, weight: .regular, design: .default))
                                .foregroundColor(Color.black)
                                .padding(.top, UIScreen.screenWidth/15)
                            
                            Text(questionText)
                                .padding(.top, UIScreen.screenWidth/20)
                                .font(.system(size:  UIScreen.screenWidth/20, weight: .regular, design: .default))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                                .frame(width: UIScreen.screenWidth/1.75)
                                
                        
                            Spacer()
                            
                            if (self.tapCount == 0){
                                
                                TextField("Charles Darwin", text: $userDataService.name)
                                    .frame(width: UIScreen.screenWidth/1.50, height: UIScreen.screenWidth/11)
                                    .multilineTextAlignment(.center)
                                    .background(Color.lightGray)
                                    .cornerRadius(25)
                            }
                            if (self.tapCount == 1){
                                
                                TextField("100", text: $userDataService.cropYield)
                                    .frame(width: UIScreen.screenWidth/1.50, height: UIScreen.screenWidth/11)
                                    .multilineTextAlignment(.center)
                                    .background(Color.lightGray)
                                    .cornerRadius(25)
                            }
                            else if (self.tapCount == 2){
                                
                                Slider(value: $farmSize, in: 0...1000, step: 5)
                                    .frame(width: UIScreen.screenWidth/1.50)
                                    .onChange(of: farmSize) { newValue in
                                        // Filter the input to allow only numbers
                                        userDataService.farmSize = String(farmSize)
                                    }
                                
                                Text(String(farmSize) + " acres")
    
                            }
                            else if (self.tapCount == 3){
                                
                                HStack(){
                                    
                                    VStack(){
                                        
                                        Button{
                                            
                                            if (!userDataService.maizeSaved){
                                                withAnimation(){
                                                    maizeForegroundColor = Color.white
                                                    maizeBackgroundColor = Color.lightGreen
                                                }
                                                userDataService.maizeSaved = true
                                                userDataService.maizeSaved = true
                                            }
                                            else {
                                                withAnimation(){
                                                    maizeForegroundColor = Color.lightGreen
                                                    maizeBackgroundColor = Color.white
                                                }
                                                userDataService.maizeSaved = false
                                            
                                            }
                                        }
                                        label:{
                                            
                                            Text("Maize")
                                                .frame(width: UIScreen.screenHeight/7.5, height: UIScreen.screenWidth/10)
                                                .foregroundColor(maizeForegroundColor)
                                                .background(maizeBackgroundColor)
                                                .cornerRadius(25)
                                                .overlay(
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(Color.lightGreen, lineWidth: 3)
                                                    )
    
                                        }
                                        .padding(.bottom)
                                        
                                        Button(action: {
                                                      withAnimation {
                                                          if !userDataService.wheatSaved {
                                                              wheatForegroundColor = .white
                                                              wheatBackgroundColor = .lightGreen
                                                          } else {
                                                              wheatForegroundColor = .lightGreen
                                                              wheatBackgroundColor = .white
                                                          }
                                                          userDataService.wheatSaved.toggle()
                                                      }
                                                  }) {
                                                      Text("Wheat")
                                                          .frame(width: UIScreen.main.bounds.height/7.5, height: UIScreen.main.bounds.width/10)
                                                          .foregroundColor(wheatForegroundColor)
                                                          .background(wheatBackgroundColor)
                                                          .cornerRadius(25)
                                                          .overlay(
                                                              RoundedRectangle(cornerRadius: 20)
                                                                  .stroke(Color.lightGreen, lineWidth: 3)
                                                          )
                                                  }
                                        
                                    }
                                    .padding(.leading, UIScreen.screenWidth/10)
                                    
                                    Spacer()
                                    
                                    VStack(){
                                        
                                        Button(action: {
                                                      withAnimation {
                                                          if !userDataService.potatoesSaved {
                                                              potatoesForegroundColor = .white
                                                              potatoesBackgroundColor = .lightGreen
                                                          } else {
                                                              potatoesForegroundColor = .lightGreen
                                                              potatoesBackgroundColor = .white
                                                          }
                                                          userDataService.potatoesSaved.toggle()
                                                
                                                      }
                                                  }) {
                                                      Text("Potatoes")
                                                          .frame(width: UIScreen.main.bounds.height/7.5, height: UIScreen.main.bounds.width/10)
                                                          .foregroundColor(potatoesForegroundColor)
                                                          .background(potatoesBackgroundColor)
                                                          .cornerRadius(25)
                                                          .overlay(
                                                              RoundedRectangle(cornerRadius: 20)
                                                                  .stroke(Color.lightGreen, lineWidth: 3)
                                                          )
                                                  }
                                                  .padding(.bottom)
                                        
                                        Button(action: {
                                                      withAnimation {
                                                          if !userDataService.riceSaved {
                                                              riceForegroundColor = .white
                                                              riceBackgroundColor = .lightGreen
                                                          } else {
                                                              riceForegroundColor = .lightGreen
                                                              riceBackgroundColor = .white
                                                          }
                                                          userDataService.riceSaved.toggle()
                                                                                            }
                                                  }) {
                                                      Text("Rice")
                                                          .frame(width: UIScreen.main.bounds.height/7.5, height: UIScreen.main.bounds.width/10)
                                                          .foregroundColor(riceForegroundColor)
                                                          .background(riceBackgroundColor)
                                                          .cornerRadius(25)
                                                          .overlay(
                                                              RoundedRectangle(cornerRadius: 20)
                                                                  .stroke(Color.lightGreen, lineWidth: 3)
                                                          )
                                                  }
                                    }
                                    .padding(.trailing, UIScreen.screenWidth/10)
                                    
                                }
                            
                            }
                            else if (self.tapCount == 4){
                               
                                TextField("Country", text: $userDataService.location)
                                    .frame(width: UIScreen.screenWidth/1.50, height: UIScreen.screenWidth/11)
                                    .multilineTextAlignment(.center)
                                    .background(Color.lightGray)
                                    .cornerRadius(25)
                    
                            }
                            
                            Spacer()
                            
                            Button(){
                                
                                if (self.tapCount == 0){
                                    withAnimation(){
                                        questionText = "What is your yearly crop yield"
                                    }
                                }
                                else if (self.tapCount == 1){
                                    withAnimation(){
                                        questionText = "What is your farm size?"
                                    }
                                }
                                else if (self.tapCount == 2){
                                    withAnimation(){
                                        questionText = "Select which crops you grow?"
                                    }
                                }
                                else if (self.tapCount == 3){
                                    withAnimation(){
                                        questionText = "Where is your farm located by country?"
                                    }
                                }
                                else{
                                    withAnimation(){
                                        userDataService.isContentViewOpen = false
                                    }
                                }
                                self.tapCount += 1
                                
    
                            }
                        label:{
                            
                            Text("Continue")
                                .frame(width: UIScreen.screenHeight/7.5, height: UIScreen.screenWidth/10)
                                .foregroundColor(Color.white)
                                .background(Color.lightGreen)
                                .cornerRadius(25)
                                .padding(.bottom, UIScreen.screenWidth/15)
                        }
                            
                    }
                }
                
            }
            
        }
        
    }
}

extension Color {
    
    static let lightGreen = Color(red: 123/255, green: 178/255, blue: 133/255)
    static let darkGreen = Color(red: 27/255, green: 32/255 , blue: 28/255)
    static let BackgroundWhite = Color(red: 242/255, green: 242/255, blue: 242/255)
    static let lightGray = Color(red: 211/255, green: 211/255, blue: 211/255)
    static let extraLightGray = Color(red: 230/255, green: 230/255, blue: 230/255)
    static let pasteRed = Color(red: 255/255, green: 87/255, blue: 51/255)
    
}

extension UIScreen{
    
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
    
}

