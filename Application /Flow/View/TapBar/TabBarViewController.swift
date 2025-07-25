//
//  TabBarViewController.swift
//  WeatherApplication
//
//  Created by Владислав Скриганюк on 21.07.2025.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    private var compositionViewController = CompositionViewController()
    
    
    //    private lazy var appearance: UIBarAppearance = {
    //        let bar = UIBarAppearance()
    //        bar.configureWithOpaqueBackground()
    //        bar.backgroundColor = UIColor(red: 70/255, green: 100/255, blue: 180/255, alpha: 1.0)
    //        return bar
    //    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compositionViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 0)
        compositionViewController.tabBarItem.imageInsets = .init(top: 10, left: 0, bottom: -10, right: 0)
        viewControllers = [compositionViewController]
     
        
        tabBar.backgroundColor = UIColor(red: 70/255, green: 100/255, blue: 180/255, alpha: 1.0)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 70/255, green: 100/255, blue: 180/255, alpha: 1.0)
        
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.stackedLayoutAppearance.normal.iconColor = .white.withAlphaComponent(0.6)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
        tabBar.standardAppearance = appearance
        
        tabBar.scrollEdgeAppearance = appearance
        
    }
    
}
