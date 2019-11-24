//
//  WeatherListViewDatasource.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

class WeatherListViewDatasource: NSObject {
    
    let configuration: WeatherListConfiguration
    weak var controller: WeatherListViewController?
    
    private var weatherDetail: [WeatherInfo] {
        
        guard let viewModel = controller?.viewModel else {
            return []
        }
        
        if isFiltering {
            return viewModel.filteredWeatherDetail ?? []
        }else{
            return viewModel.weatherDetail ?? []
        }
    }
    
    private var isSearchBarEmpty: Bool {
        return controller?.searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        guard let vc = controller else {
            return false
        }
        let searchBarScopeIsFiltering = vc.searchController.searchBar.selectedScopeButtonIndex != 0
        return vc.searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    init(configuration: WeatherListConfiguration) {
        self.configuration = configuration
    }
    
}

extension WeatherListViewDatasource {
    
    func registerTableCell(tableView: UITableView) {
        tableView.register(WeatherTableCell.self, forCellReuseIdentifier: "WeatherCell")
    }
}

extension WeatherListViewDatasource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as? WeatherTableCell else {
            return UITableViewCell()
        }
        cell.configureCell(detail: weatherDetail[indexPath.row])
        return cell
    }
    
}

extension WeatherListViewDatasource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


