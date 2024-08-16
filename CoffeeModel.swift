//
//  CoffeeModel.swift
//  UberSwiftUI
//
//  Created by Kyle Modina on 7/20/24.
//

import Foundation
import SwiftUI

struct CoffeeData: Codable, Identifiable {
    var id = UUID()
    var coffeePlace: String
    var ratings: [String]
    var textFields: [String]
    var selectedImages: [Data] // Store images as Data
}

