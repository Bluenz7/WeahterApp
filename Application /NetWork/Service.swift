//
//  Network.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 27.05.2025.
//

import Foundation

class WeatherService {
    
    func fetchForecast(completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let apiKey = "fa8b3df74d4042b9aa7135114252304"
        let latitude = "50.4501"
        let longitude =  "30.5234"
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(latitude),\(longitude)&days=7&aqi=no&alerts=no"
        
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
