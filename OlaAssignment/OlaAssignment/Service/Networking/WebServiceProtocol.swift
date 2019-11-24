//
//  WebServiceProtocol.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation

protocol WebServiceProtocol {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void)
}
