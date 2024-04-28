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
    @State private var predictedYield = 0
    @State private var predictedProfit = 0
    
    func colorForSensorStatus(sensor: Sensor) -> Color {
        return sensor.isActive ? Color.lightGreen : Color.pasteRed
    }
    
    func getSensor(index: Int) -> String{
        
        if (userDataService.sensorsList[index].isActive){
            return "Active"
        }
        else{
            return "Off"
        }
    }
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
              
                VStack(spacing: 0){
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/2.75)
                        .padding(.top)
                        .overlay(){
                            
                            VStack(){
                                
                                HStack(){
                                    
                                    Text("Dashboard")
                                        .font(.system(size: UIScreen.screenWidth/13, weight: .bold, design: .default))
                                        .padding(.leading)
                                        .padding(.top, UIScreen.screenHeight/20)
                                    
                                    Spacer()
                                    
                                    ZStack(){
                                        
                                        Circle()
                                            .stroke(lineWidth: 4)  // Adjust the thickness of the ring
                                            .foregroundColor(Color.darkGreen)  // Set the color of the ring
                                            .padding(.trailing)
                                            .padding(.top, UIScreen.screenHeight/20)
                                            .frame(width: UIScreen.screenWidth/3.75, height: UIScreen.screenWidth/3.75)
                                        
                                        userDataService.profileImage
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.screenWidth/8, height:  UIScreen.screenWidth/8)
                                            .clipShape(.circle)
                                            .padding(.trailing)
                                            .padding(.top, UIScreen.screenHeight/20)
                                    }
                                }
                               
                                   
                                VStack(spacing:20){
                                        
                                    Text("Predicted Pesticide Use")
                                        .font(.system(size: UIScreen.screenWidth/25, weight: .regular, design: .default))
                                        .foregroundColor(Color.black)
                                        
                                    Text(String(userDataService.predictedPesticides))
                                            .font(.system(size: UIScreen.screenWidth/15, weight: .regular, design: .default))
                                            .foregroundColor(Color.red)
                                        
                                }
                                .padding(.top)
                                
                                YieldChartView()
                                    .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/10)
                                
                                Spacer()
                            }
                            
                        }
                    
                    HStack(){
                        
                        Text("Sensors")
                            .font(.system(size: UIScreen.screenWidth/20, weight: .bold, design: .default))
                            .lineLimit(1)
                            .padding(.leading)
                            .padding(.top)
                        
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 20) {
                          
                            ForEach(0..<userDataService.sensorsList.count) { index in
                                
                                Rectangle()
                                    .fill(colorForSensorStatus(sensor: userDataService.sensorsList[index]))
                                    .frame(width: UIScreen.screenWidth/3.5, height: UIScreen.screenWidth/3)
                                    .background(Color.lightGray)
                                    .cornerRadius(10)
                                    .shadow(radius: 2)

                                    .overlay(){
                                        VStack(){
                                            
                                            Text(userDataService.sensorsList[index].name)
                                                .font(.system(size: UIScreen.screenWidth/23, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                            
                                            Text(getSensor(index: index))
                                                .font(.system(size: UIScreen.screenWidth/28, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                            
                                            Text(String(userDataService.sensorsList[index].readings))
                                                .font(.system(size: UIScreen.screenWidth/34, weight: .bold, design: .default))
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                            }
                        }
                        .padding(.leading)
                    }
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/5)
                    
                    HStack(){
                        Text("Notifacations")
                            .font(.system(size: UIScreen.screenWidth/20, weight: .bold, design: .default))
                            .lineLimit(1)
                            .padding(.leading)
                            .padding(.bottom)
                        
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 20) {
                          
                            ForEach(0..<userDataService.notifications.count) { index in
                                
                                VStack(){
                                    
                                    Text(userDataService.notifications[index].name)
                                        .padding()
                                    
                                    Text(userDataService.notifications[index].info)
                                        .padding(.bottom)
                                        .padding(.horizontal)
                                }
                                .frame(width: UIScreen.screenWidth/1.25)
                                .background(Color.lightGray)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                    
                            }
                        }
                        .padding(.leading)
                    }
                    .frame(width: UIScreen.screenWidth)
                    
                }
            }
        }
    }

}

