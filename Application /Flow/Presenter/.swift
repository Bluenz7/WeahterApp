////
////  NewPresenter.swift
////  WeatherApplication
////
////  Created by Владислав Скриганюк on 26.05.2025.
////
//
//import Foundation
//import UIKit
//
//
//final class WeatherPresenter: WeatherPresenterProtocol {
//    weak var view: WeatherViewProtocol?
//    
//    init(view: WeatherViewProtocol) {
//        self.view = view
//    }
//    
//    func loadWeather() {

//        let current = WeatherItem(temperature: "21°",
//                                  condition: "Сонячно",
//                                  hour: nil,
//                                  hourlyTemp: nil,
//                                  hourlyIcon: nil,
//                                  day: nil,
//                                  minTemp: nil,
//                                  maxTemp: nil,
//                                  dailyIcon: nil
//        )
//        
//        let hourly: [WeatherItem] = (0..<12).map { i in
//            WeatherItem(temperature: nil,
//                        condition: nil,
//                        hour: "\(i + 1) год",
//                        hourlyTemp: "\(Int.random(in: 18...26))°",
//                        hourlyIcon: "cloud.sun",
//                        day: nil,
//                        minTemp: nil,
//                        maxTemp: nil,
//                        dailyIcon: nil
//            )
//        }
//        
//        let daily: [WeatherItem] = [
//            WeatherItem(temperature: nil,
//                        condition: nil,
//                        hour: nil,
//                        hourlyTemp: nil,
//                        hourlyIcon: nil,
//                        day: "Пн",
//                        minTemp: "17°",
//                        maxTemp: "25°",
//                        dailyIcon: "cloud.sun"),
//            WeatherItem(temperature: nil,
//                        condition: nil,
//                        hour: nil,
//                        hourlyTemp: nil,
//                        hourlyIcon: nil,
//                        day: "Вт",
//                        minTemp: "18°",
//                        maxTemp: "26°",
//                        dailyIcon: "cloud.bolt"),
//            WeatherItem(temperature: nil,
//                        condition: nil,
//                        hour: nil,
//                        hourlyTemp: nil,
//                        hourlyIcon: nil,
//                        day: "Ср",
//                        minTemp: "19°",
//                        maxTemp: "27°",
//                        dailyIcon: "sun.max")
//        ]
//    }
//}
//
//protocol WeatherViewProtocol: AnyObject {
//    func displaySnapshot(_ snapshot: NSDiffableDataSourceSnapshot<WeatherSection, WeatherItem>)
//}
//
//protocol WeatherPresenterProtocol: AnyObject {
//    func loadWeather()
//}
