//
//  TierNameView.swift
//  UberSwiftUI
//
//  Created by Kyle Modina on 6/25/24.
//

import SwiftUI

struct TierNameView: View {
    let label: String
    
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(minWidth: 30, idealWidth: .infinity, maxWidth: .infinity, minHeight: 30, idealHeight: .infinity, maxHeight: .infinity)
            .cornerRadius(20)
            .overlay(
                Text(label)
                    .foregroundColor(.black)
                    .font(.headline)
                    .lineLimit(1) // Ensure only one line of text is shown
                    .minimumScaleFactor(0.5) // Adjust minimum scale factor as needed
            )
    }
}


#Preview {
    TierNameView(label: "S Tier")
}
