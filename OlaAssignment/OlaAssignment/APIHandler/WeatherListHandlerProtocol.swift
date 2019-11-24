//
//  WeatherListHandlerProtocol.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation

protocol WeatherListHandlerProtocol {
    func fetchWeatherInfo(withCityname cityName: String, completion: @escaping ((Result<WeatherDetail, ErrorResult>) -> Void))
}
