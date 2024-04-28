//
//  userData.swift
//  Nutria
//
//  Created by Jones Mays II on 4/27/24.
//

import SwiftUI

class UserDataService: ObservableObject {
    
    @Published public var isContentViewOpen = true
    @Published public var profileImage = Image("charlesDarwin")
    @Published public var location = ""
    @Published public var farmSize = ""
    @Published public var crops = []
    @Published public var maizeSaved = true
    @Published public var riceSaved = true
    @Published public var wheatSaved = true
    @Published public var potatoesSaved = true
    
    
}
