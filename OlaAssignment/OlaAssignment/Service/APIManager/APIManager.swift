//
//  APIManager.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation

struct APIManager {
    private static let baseURLString = "https://api.openweathermap.org/data/2.5/"
    private static let apiKey = "de28d9fa26177a18c4a80a3acb8edc35"
    private static let forecastUnit = "forecast?"


    // MARK: - General Methods
    public static func weatherAPIURL(_ cityName: String) -> URL {
        let weatherInfoUrl =  baseURLString + forecastUnit + "q=\(cityName)&APPID=\(apiKey)"
        let finalURL = URL(string: weatherInfoUrl)!
        return finalURL
    }
}
