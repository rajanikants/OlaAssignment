//
//  WebService.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

class WebService: WebServiceProtocol {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void) {
        print("url :", resource.url)
        URLSession.shared.dataTask(with: resource.url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
            }.resume()
    }
}
