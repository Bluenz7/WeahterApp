//
//  ListItem.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 20.05.2025.
//

import Foundation

//MARK: - Model.
struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String?
    let region: String?
    let country: String?
}

struct CurrentWeather: Codable, Hashable {
    let temp_c: Double?
    let condition: WeatherCondition
}

struct WeatherCondition: Codable, Hashable {
    let text: String?
    let icon: String?
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable, Hashable {
    let date: String?
    let hour: [HourlyWeather]
    let day: DayWeather
}

struct HourlyWeather: Codable, Hashable {
    let time: String?
    let temp_c: Double?
    let condition: WeatherCondition
}

struct DayWeather: Codable, Hashable {
    let maxtemp_c: Double?
    let mintemp_c: Double?
    let condition: WeatherCondition
}


