//
//  WeatherDetail.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation

// MARK: - WeatherDetail
struct WeatherDetail: Decodable {
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Decodable {
    let name: String
    let country: String
}

// MARK: - List
struct List: Decodable {
    let main: MainClass
    let wind: Wind
}

// MARK: - MainClass
struct MainClass: Decodable {
    let temp, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

