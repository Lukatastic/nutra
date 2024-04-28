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
    @Published public var name = ""
    @Published public var location = ""
    @Published public var farmSize = ""
    @Published public var crops = []
    @Published public var maizeSaved = false
    @Published public var riceSaved = false
    @Published public var wheatSaved = false
    @Published public var potatoesSaved = false
    @Published public var cropYield = ""
    @Published public var predictedPesticides = "0"
    @Published public var sensorsList = [
        
        Sensor(name: "Temperature Sensor", location: "Warehouse 1", isActive: true, readings: 22.5),
        Sensor(name: "Humidity Sensor", location: "Greenhouse 3", isActive: false, readings: 48.3),
        Sensor(name: "Pressure Sensor", location: "Lab 2", isActive: true, readings: 101.6),
        Sensor(name: "PH Sensor", location: "Office 5", isActive: false, readings: 350.2),
        Sensor(name: "Nitrate Sensor", location: "Garage 6", isActive: true, readings: 0.0)
        
    ]
    @Published public var notifications = [
        Notification(name: "Water Schedule Update",
                     dueDate: "April 28, 2024",
                     info: "Reduce watering to twice a week to prevent over-watering and reduce fungal growth."),
        Notification(name: "Fertilizer Reminder",
                     dueDate: "May 1, 2024",
                     info: "It's time to apply a slow-release fertilizer to promote healthy growth without excess runoff."),
        Notification(name: "Pesticide Application",
                     dueDate: "May 15, 2024",
                     info: "Spot treat areas with pest activity using organic pesticides to minimize environmental impact.")
    ]

    // Sample Suggestions
    @Published public var suggestions = [
        Suggestion(name: "Integrated Pest Management",
                   info: "Consider adopting IPM practices to reduce the need for chemical pesticides and improve crop yield."),
        Suggestion(name: "Rainwater Harvesting",
                   info: "Collect and use rainwater for irrigation to decrease dependency on groundwater and reduce costs."),
        Suggestion(name: "Soil Health Monitoring",
                   info: "Regular soil tests can help optimize fertilizer use and avoid excessive nutrient application.")
    ]


    
}


struct Sensor {
    
    var name: String
    var location: String
    var isActive: Bool
    var readings: Double
}

struct Notification{
    
    var name: String
    var dueDate: String
    var info: String
    
}

struct Suggestion{
    
    var name: String
    var info: String
    
}
