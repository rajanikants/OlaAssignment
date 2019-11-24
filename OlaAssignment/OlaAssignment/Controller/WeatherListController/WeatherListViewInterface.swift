//
//  WeatherListViewInterface.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

protocol WeatherListViewModelProtocol {
    var dataChange: ((Bool) -> Void)? { get set }
    func fetchWeatherInfo(cities: [String])
    func filterData(searchText: String)
}

extension WeatherListViewController {
    static func buildController(configuration: WeatherListConfiguration) -> WeatherListViewController {
        let listView = WeatherListViewController(configuration: configuration)
        let viewModel = WeatherListViewModel(weatherListHandler: WeatherListHandler())
        listView.viewModel = viewModel
        return listView
    }
}
