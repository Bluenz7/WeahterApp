//
//  CompositionViewController.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 23.06.2025.
//

import Foundation
import SnapKit

class CompositionViewController: UIViewController {
    
    //MARK: - Private properties.
    private var compositionView = CompositionView()
    
    //MARK: - Calling BackgorundView.
    private var weatherBackgroundView: AnimatedWeatherBackgroundView?
    
    // MARK: - Presenter.
    private lazy var presenter: WeatherPresenter = {
        return WeatherPresenter(view: self, weatherPresenter: self)
    }()
   
    //MARK: - Life Cycle.
    override func viewDidLoad() {
        view = compositionView
        presenter.loadWeather()
    }
    
    //MARK: - Setup Background View.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if weatherBackgroundView == nil {
            let bg = AnimatedWeatherBackgroundView(frame: view.bounds)
            weatherBackgroundView = bg
            view.addSubview(bg)
            view.sendSubviewToBack(bg)
        }
    }
}

extension CompositionViewController: WeahterPresenterProtocol {
    func updateTemperature(country: String, temperature: Double, condition: String) {
        compositionView.updateTemperature(country: country, temperature: temperature, condition: condition)
    }
    func setCollectionModel(param: CollectionModel) {
        compositionView.setCollectionModel(param: param)
    }
}
