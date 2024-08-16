//
//  CoffeeViewData.swift
//  UberSwiftUI
//
//  Created by Kyle Modina on 6/26/24.
//

import SwiftUI

struct CoffeeViewData: Identifiable, Codable {
    let id: UUID
    let title: String

    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}


