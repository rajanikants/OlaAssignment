//
//  Result.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

public enum NetworkResult<T> {
    case success(T)
    case failure(Error)
}
