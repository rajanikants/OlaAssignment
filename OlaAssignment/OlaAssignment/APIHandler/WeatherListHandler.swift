//
//  WeatherListHandler.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

class WeatherListHandler: WeatherListHandlerProtocol {
    
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol = WebService()) {
        self.webService = webService
    }
    
    func fetchWeatherInfo(withCityname cityName: String, completion: @escaping ((Result<WeatherDetail, ErrorResult>) -> Void)) {
        
        let weatherURL = APIManager.weatherAPIURL(cityName)
        let cityResource = Resource<WeatherDetail>(url: weatherURL) { data in
            let cityDetailModel = try? JSONDecoder().decode(WeatherDetail.self, from: data)
            return cityDetailModel
        }
        
        self.webService.load(resource: cityResource) { response in
            if let result = response {
                completion(.success(result))
            } else {
                completion(.failure(.parser(string: "Error while parsing json data")))
            }
        }
    }
}

