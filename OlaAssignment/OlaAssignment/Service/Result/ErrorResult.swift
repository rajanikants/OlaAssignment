//
//  ErrorResult.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
