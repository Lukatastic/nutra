//
//  YieldChartView.swift
//  Nutria
//
//  Created by Jones Mays II on 4/28/24.
//

import SwiftUI
import Charts

struct YieldChartView: View {
    
    let statusDataHistory = [
        
        statusData(name: "Yield", rate: 14.5, year: 2021),
        statusData(name: "Yield", rate: 18.2, year: 2022),
        statusData(name: "Yield", rate: 20.8, year: 2023),
        statusData(name: "Yield", rate: 23.4, year: 2024),
        statusData(name: "Yield", rate: 26.1, year: 2025),
        
    ]

       var body: some View {
        
           Chart {
               ForEach(statusDataHistory, id: \.year) { data in
                   AreaMark(
                       x: .value("Year", data.year),
                       y: .value("Rate", data.rate)
                   )
                   .interpolationMethod(.catmullRom)
                   .foregroundStyle(by: .value("Type", data.name))

               }
               
           }
           .chartXScale(domain: 2021...2025)
           .chartXAxis(.hidden)
           .chartYAxis(.hidden)
           

       }
    
}

struct statusData {
    var name: String
    var rate: Double
    var year: Int
}
