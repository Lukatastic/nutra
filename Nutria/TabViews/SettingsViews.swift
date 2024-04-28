//
//  SettingsViews.swift
//  Nutria
//
//  Created by Jones Mays II on 4/28/24.
//

import SwiftUI
import PhotosUI

struct SettingsView: View {
    
    @StateObject var userDataService: UserDataService
    @State private var animateGradient: Bool = false
    
    @State private var profileItem: PhotosPickerItem?
    @State private var numberString = ""
    @State private var cropYieldString = ""
    
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
                
                VStack(spacing: UIScreen.screenWidth/15){
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: UIScreen.screenWidth/1.25 , height: UIScreen.screenHeight/3)
                        .cornerRadius(15)
                        .overlay(){
                            
                            VStack(){
                                
                                ZStack(){
                                    
                                    Circle()
                                        .stroke(lineWidth: 5)  // Adjust the thickness of the ring
                                        .foregroundColor(Color.darkGreen)  // Set the color of the ring
                                        .frame(width: UIScreen.screenWidth/2.30, height: UIScreen.screenWidth/2.30)
                                    
                                    userDataService.profileImage
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.screenWidth/2.5, height:  UIScreen.screenWidth/2.5)
                                        .clipShape(.circle)
                                        .overlay(){
                                            
                                            VStack(){
                                                
                                                Spacer()
                                                
                                                HStack(){
                                                    
                                                    Spacer()
                                                    
                                                    PhotosPicker("+", selection: $profileItem, matching: .images)
                                                        .multilineTextAlignment(.center)
                                                        .font(.system(size:  UIScreen.screenWidth/10, weight: .regular, design: .default))
                                                        .frame(width: UIScreen.screenWidth/10, height:  UIScreen.screenWidth/10, alignment: .center)
                                                        .background(Color.lightGreen)
                                                        .foregroundColor(Color.darkGreen)
                                                        .clipShape(.circle)
                                                    
                                                }
                                                
                                            }
                                            
                                        }.frame(width: UIScreen.screenWidth/2.5, height:  UIScreen.screenWidth/2.5)
                                    
                                }
                                
                                Text(userDataService.name)
                                    .font(.system(size: UIScreen.screenWidth/20, weight: .regular, design: .default))
                                    .padding(.top)
                                
                            }
                        }
                        .padding(.top)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: UIScreen.screenWidth/1.25, height: UIScreen.screenWidth/7.5)
                        .cornerRadius(15)
                        .overlay(){
                            
                            HStack(){
                                
                                Text("Location:")
                                    .font(.system(size: UIScreen.screenWidth/20, weight: .regular, design: .default))
                                
                                TextField(" Country", text: $userDataService.location)
                            }
                            .padding(.horizontal)
                        }
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: UIScreen.screenWidth/1.25, height: UIScreen.screenWidth/7.5)
                        .cornerRadius(15)
                        .overlay(){
                            
                            HStack(){
                                
                                Text("Farm Size:")
                                    .font(.system(size: UIScreen.screenWidth/20, weight: .regular, design: .default))
                                    .lineLimit(1)
                                
                                TextField(" 100", text: $userDataService.farmSize)
                                            .keyboardType(.decimalPad)
                                            .onChange(of: userDataService.farmSize) { newValue in
                                                // Filter the input to allow only numbers
                                                userDataService.farmSize = userDataService.farmSize.filter { "0123456789".contains($0) }
                                            }
                            }
                            .padding(.horizontal)
                        }
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: UIScreen.screenWidth/1.25, height: UIScreen.screenWidth/7.5)
                        .cornerRadius(15)
                        .overlay(){
                            
                            HStack(){
                                
                                Text("Target Crop Yield:")
                                    .font(.system(size: UIScreen.screenWidth/20, weight: .regular, design: .default))
                                    .lineLimit(1)
                                
                                TextField(" 100", text: $userDataService.cropYield)
                                            .keyboardType(.decimalPad)
                                            .onChange(of: userDataService.cropYield) { newValue in
                                                // Filter the input to allow only numbers
                                                userDataService.cropYield =  userDataService.cropYield.filter { "0123456789".contains($0) }
                                            }
                            }
                            .padding(.horizontal)
                        }
                                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: UIScreen.screenWidth/1.25,  height: UIScreen.screenHeight/5)
                        .cornerRadius(15)
                        .overlay(){
                            
                            HStack(){
                                
                                Text("Preferences:")
                                    .font(.system(size: UIScreen.screenWidth/20, weight: .regular, design: .default))
                                    .lineLimit(1)
                                    .padding(.leading)
                                
                                Spacer()
                                
                                VStack(){
                                    preferencesView(savedButtonPressed: $userDataService.maizeSaved, name: "Maize")
                                    preferencesView(savedButtonPressed: $userDataService.riceSaved, name: "Rice")
                                    preferencesView(savedButtonPressed: $userDataService.wheatSaved, name: "Wheat")
                                    preferencesView(savedButtonPressed: $userDataService.potatoesSaved, name: "Potatoes")
                                }
                    
                            }
                            .padding(.horizontal)
                        }
                    
                    Button{
                        
                    }
                    label:{
                    
                        Text("Update Predictions")
                            .font(.system(size: UIScreen.screenWidth/25, weight: .medium, design: .default))
                            .padding(.vertical)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .background(Color.darkGreen)
                            .cornerRadius(25)
                    }
                    
                    
                    Spacer()
                    
                }
                
            }
           
        }
        .onChange(of: profileItem) { newValue in
            Task {
                if let loaded = try? await profileItem?.loadTransferable(type: Data.self) {
                    //This loads the new profileImage//
                    userDataService.profileImage = Image(uiImage: UIImage(data: loaded)!)
                    
                } else {
                    print("Failed")
                }
            }
    }

    }

}


struct preferencesView: View {
    
    @Binding public var savedButtonPressed: Bool
    @State public var name: String
    @State public var savedForegroundColor = Color.white
    @State public var savedBackgroundColor = Color.lightGreen
    
    var body: some View {
        
        VStack(){
            
            Button{
                
                if (!savedButtonPressed){
                    withAnimation(){
                        savedForegroundColor = Color.white
                        savedBackgroundColor = Color.lightGreen
                    }
                    savedButtonPressed = true
                }
                else {
                    withAnimation(){
                        savedForegroundColor  = Color.lightGreen
                        savedBackgroundColor = Color.white
                    }
                    savedButtonPressed = false
                }
            }
        label:{
            
            Text(name)
                .frame(width: UIScreen.screenHeight/7.5, height: UIScreen.screenWidth/15)
                .foregroundColor(savedForegroundColor)
                .background(savedBackgroundColor)
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.lightGreen, lineWidth: 3)
                )
            
        }
            
            
        }
    }
    
}
