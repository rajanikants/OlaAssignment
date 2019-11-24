//
//  WeatherInfo+Model.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation
import CoreData

extension WeatherInfo {
    
    static internal func insertWeatherInfo(_ weatherDetail:WeatherDetail, context:NSManagedObjectContext) -> WeatherInfo?
    {
        guard let mainDetail = weatherDetail.list.first?.main else {
            return nil
        }
        
        let cityName = weatherDetail.city.name
        let temperature = mainDetail.temp.roundedString
        let minTemp = mainDetail.tempMin.roundedString
        let maxTemp = mainDetail.tempMax.roundedString
        
        let detail = WeatherInfo(context:context)
        detail.cityName = cityName
        detail.maxTemp = maxTemp
        detail.minTemp = minTemp
        detail.temperature = temperature
        return detail
    }
    
    static internal func fetchWeatherInfo(_ predicate:NSPredicate, context:NSManagedObjectContext) -> [WeatherInfo]
    {
        let fetchRequest:NSFetchRequest = WeatherInfo.fetchRequest()
        fetchRequest.predicate = predicate
        
        var fetchedObjects = [WeatherInfo]()
        do {
            fetchedObjects = try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return fetchedObjects
    }
    
    static internal func fetchAllObjects(context:NSManagedObjectContext) -> [WeatherInfo]
    {
        let fetchRequest:NSFetchRequest = WeatherInfo.fetchRequest()
        
        var fetchedObjects = [WeatherInfo]()
        do {
            fetchedObjects = try context.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
        return fetchedObjects
    }
    
    static internal func deleteAllObjects(context:NSManagedObjectContext) -> Void
    {
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: WeatherInfo.className)
        do {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(deleteRequest)
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
