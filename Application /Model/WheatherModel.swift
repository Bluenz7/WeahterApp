//
//  WheatherModel.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Foundation

enum ListSection {
    
    case firstCollection(WheatherModel)
    case secondCollection(WeatherResponse)
    

    var title: String {
        switch self {
        case .firstCollection(_):
            return "Прогноз почасовой"
        case .secondCollection(_):
            return "10-дневный прогноз"
        }
    }
    
}

struct WheatherModel {
    var hourSection: [HourInfo]
}

struct HourInfo: Codable, Hashable {
    let time: String?
    let temp_c: Double?
    let condition: WeatherInfo
}
struct WeatherInfo: Codable, Hashable {
    let text: String?
    let icon: String?
}
