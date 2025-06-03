//
//  WheatherModel.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Foundation

enum ListSection {
    
    case firstCollection(WeatherResponse)
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
