//
//  TabView.swift
//  Nutria
//
//  Created by Jones Mays II on 4/27/24.
//

import SwiftUI

struct TabViewManager: View {
    
    @StateObject var userDataService: UserDataService
    
    var body: some View {
        
        ZStack(){
            
            TabView {
                
                HomeView(userDataService: userDataService)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                SuggestionsView(userDataService: userDataService)
                    .tabItem {
                        Label("Suggestions", systemImage: "pencil.and.list.clipboard")
                    }
                
                SettingsView(userDataService: userDataService)
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                
            }
        }
    }

}
