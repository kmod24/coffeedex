//
//  CoffeeBackButton.swift
//  UberSwiftUI
//
//  Created by Kyle Modina on 6/26/24.
//

import SwiftUI

struct CoffeeBackButton: View {
    var body: some View {
        VStack {
            Image("coffee_icon")
                .resizable()
                .frame(width: 30, height: 30)
        }
    
    }
}

#Preview {
    NavigationView {
        CoffeeBackButton()
    }
}
