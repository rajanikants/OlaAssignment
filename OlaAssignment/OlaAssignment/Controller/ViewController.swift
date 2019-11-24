//
//  ViewController.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var stubActionButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       stubActionButton.isHidden = shouldEnableStubButton()
    }
    
    func shouldEnableStubButton() -> Bool {
        //check weather data saved or not
        if let objects = WeatherInfo.fetchAllObjects(),
            !objects.isEmpty {
            return false
        }
        return true
    }
}

//Mark:- IBActions
extension ViewController {
    
    @IBAction func actionOnOpenWeather(_ sender: Any){
        
         //hardcoded cities to mock the data
               let cities = ["Bhopal", "Pune", "Jaipur", "Mumbai", "Indore", "Nagpur", "Faridabad", "Bangalore", "Delhi", "Chennai"]

        let config = WeatherListConfiguration(cities: cities)
        let listVC = WeatherListViewController.buildController(configuration: config)
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    
    @IBAction func actionOnOpenStubWeather(_ sender: Any){

        let config = WeatherListConfiguration(cities: [], useStub: true)
        let listVC = WeatherListViewController.buildController(configuration: config)
        navigationController?.pushViewController(listVC, animated: true)
    }
    
}

