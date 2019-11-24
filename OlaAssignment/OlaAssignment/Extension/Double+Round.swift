//
//  Double+Round.swift
//  OlaAssignment
//
//  Created by Rajanikant shukla on 11/24/19.
//  Copyright © 2019 Rajanikant shukla. All rights reserved.
//

import Foundation

extension Double {
    var roundedString: String {
        return String(format: "%.2f", self)
    }
}
