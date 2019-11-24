//
//  WeatherInfo+Parser.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import UIKit

extension WeatherInfo {
    
    static func saveAllCitiesWeatherInfo(list:[WeatherDetail]) -> [WeatherInfo]? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        var tempArray = [WeatherInfo]()
        
        list.forEach { (weatherObject) in
            if let modelObject = WeatherInfo.insertWeatherInfo(weatherObject, context: context) {
                tempArray.append(modelObject)
            }
        }
        WeatherInfo.saveContext(context)
        
        //return saved objects
        return tempArray
    }
    
    static func fetchAllObjects() -> [WeatherInfo]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        return WeatherInfo.fetchAllObjects(context: context)
    }
    
    static func deleteAllObjects(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            WeatherInfo.deleteAllObjects(context: context)
        }
    }
}
