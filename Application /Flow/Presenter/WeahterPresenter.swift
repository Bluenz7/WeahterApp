////
////  WeahterPresenter.swift
////  WeatherApplication
////
////  Created by Владислав Скриганюк on 20.05.2025.
////
//
import Foundation

protocol WeahterPresenterProtocol: AnyObject {
    func updateTemperature(param: CompositionModel)
    func setCollectionModel(param: CollectionModel)
}

class WeatherPresenter {
    weak var weatherPresenter: WeahterPresenterProtocol?
    weak var view: CompositionViewController?
    let service = WeatherService()
    
    // MARK: - Inizialized WeatherVC
    init(view: CompositionViewController, weatherPresenter: WeahterPresenterProtocol) {
        self.view = view
        self.weatherPresenter = weatherPresenter
    }
    //MARK: - Setup CompositionModel.
    func buildCompositionModel(by data: WeatherResponse) -> CompositionModel {
        
        let compositionModel: CompositionModel = CompositionModel(
            country: data.location.region,
            temperature: data.current.temp_c,
            condition: data.current.condition.text)
        
        return compositionModel
    }
    //MARK: - Setupr CollectionModel.
    private func buildModel(by data: WeatherResponse) -> CollectionModel {
        
        var collectionModel: CollectionModel = CollectionModel(sections: [])

        var forecastHourSection = CollectionSection(items: [], title: "Прогноз почасовой")
        
        data.forecast.forecastday.enumerated().forEach { index, hoursOfTheDay in
            guard index <= 1 else { return }
            hoursOfTheDay.hour.forEach { hour in
                forecastHourSection.items.append(
                    CollectionItem(
                        cellType: FirstCollectionViewCell.self,
                        cellModel: FirstCollectionViewCell.Model(
                            hour: extractHour(from: hour.time ?? ""),
                            iconURL: URL(string: "http:" + (hour.condition.icon ?? "")),
                            temp: hour.temp_c
                        )
                    )
                )
            }
        }
        collectionModel.sections.append(forecastHourSection)
        
        var forecastDaySection = CollectionSection(items: [], title:  "10-дневный прогноз")
        
        data.forecast.forecastday.enumerated().forEach { index, forecastDay in
            guard index <= 2 else { return }
            
            forecastDaySection.items.append(
                CollectionItem(
                    cellType: SecondCollectionViewCell.self,
                    cellModel: SecondCollectionViewCell.Model(
                        date: forecastDay.date ?? "",
                        icon: URL(string: "http:" + (forecastDay.day.condition.icon ?? "")),
                        mintemp_c: forecastDay.day.mintemp_c ?? 0,
                        maxtemp_c: forecastDay.day.maxtemp_c ?? 0
                    )
                )
            )
           
            if index <= 1 {
                forecastDaySection.items.append(
                    CollectionItem(
                        cellType: SeparatorCollectionViewCell.self,
                        cellModel: []
                    )
                )
            }
        }
        collectionModel.sections.append(forecastDaySection)
        
        return collectionModel
    }
    
    
    private func extractHour(from dateTimeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = formatter.date(from: dateTimeString) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "HH"
            return hourFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    private func extractDay(from dataTimeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = formatter.date(from: dataTimeString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "yyyy-MM-dd"
            return dayFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func loadWeather() {
        service.fetchForecast { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let forecast):
                    guard let self else { return }
                    print(self)
                    print("✅ Forecast loaded:", forecast)

                    self.weatherPresenter?.updateTemperature(param: self.buildCompositionModel(by: forecast))
                    self.view?.setCollectionModel(param: self.buildModel(by: forecast))
                    
                case .failure(let error):
                    print("Не удалось загрузить погоду: \(error.localizedDescription)")
                }
            }
        }
    }
}

//   let forecastDays = forecast.forecast.forecastday
//   guard forecastDays.randomElement() != nil else { return }
//   guard let country = forecast.location.region else { return }
//   guard let day = forecast.current.temp_c else { return }
//   guard let condition = forecast.current.condition.text else { return }
//                    _ = Array(forecastDays.dropFirst().prefix(3))
//                    let todayHours = today.hour.filter {
//                        let formatter = ISO8601DateFormatter()
//                        formatter.formatOptions = [
//                            .withFullDate,
//                            .withTime,
//                            .withDashSeparatorInDate,
//                            .withColonSeparatorInTime
//                        ]
//                        guard let hourDate = formatter.date(from: $0.time ?? "") else { return false }
//                        return hourDate > Date()
//                    }
