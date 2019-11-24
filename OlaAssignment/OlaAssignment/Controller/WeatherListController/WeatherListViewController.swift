//
//  WeatherListViewController.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

struct WeatherListConfiguration {
    let cities: [String]
    let useStub: Bool
    
    init(cities: [String], useStub: Bool = false) {
        self.cities = cities
        self.useStub = useStub
    }
}


class WeatherListViewController: UIViewController {
    
    lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.estimatedRowHeight = 50
        table.allowsSelection = false
        table.tableFooterView = UIView()
        return table
    }()
    
    private lazy var activityIndi: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.style = .large
        return activity
    }()
    
    private var dataSource: WeatherListViewDatasource
    var viewModel: WeatherListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchViewController()
        getWeatherData()
        prepareViewModelObserver()
        
    }
    
    init(configuration: WeatherListConfiguration) {
        dataSource = WeatherListViewDatasource(configuration: configuration)
        super.init(nibName: nil, bundle: nil)
        dataSource.controller = self
        dataSource.registerTableCell(tableView: tableView)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- UI setup
private extension WeatherListViewController {
    
    func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(activityIndi)
        setupConstraint()
    }
    
    func setupConstraint()  {
        activityIndi.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            activityIndi.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndi.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndi.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndi.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

private extension WeatherListViewController {
    
    func getWeatherData() {
        
        if dataSource.configuration.useStub {
            viewModel?.fetchStoredWeatherObjects()
        }else{
            activityIndi.startAnimating()
            viewModel?.fetchWeatherInfo(cities: dataSource.configuration.cities)
        }
        
    }
    
    func prepareViewModelObserver() {
        viewModel?.dataChange = { (sucess) in
            self.activityIndi.stopAnimating()
            if sucess {
                self.reloadTableView()
            }
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
}

extension WeatherListViewController {
    
    func setupSearchViewController() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel?.filterData(searchText: searchText)
    }
}

extension WeatherListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    guard let searchText = searchBar.text else {
        return
    }
    filterContentForSearchText(searchText)
  }
}

extension WeatherListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    guard let searchText = searchBar.text else {
        return
    }
    filterContentForSearchText(searchText)
  }
}

