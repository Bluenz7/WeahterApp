////
////  WeahterPresenter.swift
////  WeatherApplication
////
////  Created by Владислав Скриганюк on 20.05.2025.
////
//
import Foundation

protocol WeahterPresenterProtocol: AnyObject {
    func updateTemperature(country: String, temperature: Double, condition: String)
}

class WeatherPresenter {
    weak var weatherPresenter: WeahterPresenterProtocol?
    weak var view: CompositionView?
    let service = WeatherService()
//    private let locationManager = LocationManager()
  
    // MARK: - Inizialized WeatherVC
    init(view: CompositionView, weatherPresenter: WeahterPresenterProtocol) {
        self.view = view
        self.weatherPresenter = weatherPresenter
    }
   
//    func attachView(_ view: CompositionView) {
//        self.view = view
//    }
    private func buildModel(by data: WeatherResponse) -> WheatherModel {
        var model: WheatherModel = WheatherModel(hourSection: [])
        data.forecast.forecastday.enumerated().forEach { index, day in
            guard index <= 1 else { return }
            day.hour.forEach { hour in
                model.hourSection.append(
                    HourInfo(
                        time: hour.time,
                        temp_c: hour.temp_c,
                        condition: WeatherInfo(
                            text: hour.condition.text,
                            icon: hour.condition.icon
                        )
                    )
                )
            }
        }
        return model
    }
    
    func loadWeather() {
        service.fetchForecast { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let forecast):
                    guard let self else { return }
                    
                    print("✅ Forecast loaded:", forecast)
                    let forecastDays = forecast.forecast.forecastday
                
                    guard let today = forecastDays.randomElement() else { return }
                    
                    let todayHours = today.hour.filter {
                        let formatter = ISO8601DateFormatter()
                        formatter.formatOptions = [
                            .withFullDate,
                            .withTime,
                            .withDashSeparatorInDate,
                            .withColonSeparatorInTime
                        ]
                        guard let hourDate = formatter.date(from: $0.time ?? "") else { return false }
                        return hourDate > Date()
                    }
                    
                    guard let day = forecast.current.temp_c else { return }
                    guard let condition = forecast.current.condition.text else { return }
                    guard let country = forecast.location.region else { return }
                            
                    let nextDays = Array(forecastDays.dropFirst().prefix(3))
                    self.view?.setSections(param: [.firstCollection(self.buildModel(by: forecast)), .secondCollection(forecast)])
                    self.weatherPresenter?.updateTemperature(country: country, temperature: day, condition: condition)
                
                    
                case .failure(let error):
                    print("Не удалось загрузить погоду: \(error.localizedDescription)")
//                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
//    func loadWeather() {
//        locationManager.onLocationUpdate = { [weak self] coordinate in
//            self?.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        }
//
//        locationManager.onLocationDenied = { [weak self] in
//            // Москва координаты.
//            self?.fetchWeather(latitude: 55.7558, longitude: 37.6176)
//        }
//
//        locationManager.requestLocation()
//    }
//
//    private func fetchWeather(latitude: Double, longitude: Double) {
//        service.fetchForecast(lat: latitude, lon: longitude) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let forecast):
//                    print("✅ Forecast loaded:", forecast)
//
//                    let forecastDays = forecast.forecast.forecastday
//                    guard let today = forecastDays.first else { return }
//
//                    let todayHours = today.hour.filter {
//                        let formatter = ISO8601DateFormatter()
//                        formatter.formatOptions = [
//                            .withFullDate,
//                            .withTime,
//                            .withDashSeparatorInDate,
//                            .withColonSeparatorInTime
//                        ]
//                        guard let hourDate = formatter.date(from: $0.time) else { return false }
//                        return hourDate > Date()
//                    }
//
//                    let nextDays = Array(forecastDays.dropFirst().prefix(3))
//                    
//                    self?.view?.setSections(param: [
//                        .firstCollection(forecast),
//                        .secondCollection(forecast)
//                    ])
//
//                case .failure(let error):
//                    print("❌ Не удалось загрузить погоду: \(error.localizedDescription)")
//                    // self?.view?.showError(error.localizedDescription)
//                }
//            }
//        }
//    }

}
