//
//  NutriaApp.swift
//  Nutria
//
//  Created by Jones Mays II on 4/27/24.
//

import SwiftUI

@main
struct NutriaApp: App {
    
    @StateObject private var userDataService = UserDataService()
    
    var body: some Scene {
        
        WindowGroup {
            
            ZStack(){
                
                TabViewManager(userDataService: userDataService)
               
                if (userDataService.isContentViewOpen){
                    ContentView(userDataService: userDataService)
                }
            }
            
        }
    }
}

