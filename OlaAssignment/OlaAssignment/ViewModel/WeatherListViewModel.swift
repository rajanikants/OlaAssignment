//
//  ListViewModel.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation

class WeatherListViewModel: WeatherListViewModelProtocol {
    
    private let weatherListHandler: WeatherListHandlerProtocol
    
    init(weatherListHandler: WeatherListHandlerProtocol) {
        self.weatherListHandler = weatherListHandler
    }
    
    var dataChange: ((Bool) -> Void)?
    
    var weatherDetail: [WeatherInfo]? {
        didSet {
            if let notifier = dataChange {
                notifier(true)
            }
        }
    }
    
    var filteredWeatherDetail: [WeatherInfo]? {
        didSet {
            if let notifier = dataChange {
                notifier(true)
            }
        }
    }
}

//MARK:- API Call
extension WeatherListViewModel {
    
    func fetchWeatherInfo(cities: [String]) {
        
        var objects: [WeatherDetail] = []
        let dispatchGroup = DispatchGroup()
        cities.forEach { (city) in
            dispatchGroup.enter()
            weatherListHandler.fetchWeatherInfo(withCityname: city, completion: { result in
                switch result {
                case .success(let object) :
                    objects.append(object)
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    break
                }
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
            })
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {return}
            self.storeWeatherData(objects: objects)
        }
    }
}

extension WeatherListViewModel {
    
    func storeWeatherData(objects: [WeatherDetail]) {
        
        //delete all old stored objects
        WeatherInfo.deleteAllObjects()
        
        //store new objects
        let storedObjects = WeatherInfo.saveAllCitiesWeatherInfo(list: objects)
        self.weatherDetail = storedObjects
    }
    
    func filterData(searchText: String) {
        guard let weatherDetail = self.weatherDetail else { return }
        let searchResult = weatherDetail.filter { (detail) -> Bool in
            guard let cityName = detail.cityName else { return false}
            return cityName.lowercased().contains(searchText.lowercased())
        }
        filteredWeatherDetail = searchResult
    }
}

//MARK:- Stored data
extension WeatherListViewModel {
    func fetchStoredWeatherObjects() {
        let objects = WeatherInfo.fetchAllObjects()
        self.weatherDetail = objects
    }
}
