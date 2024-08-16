//
//  TierButton.swift
//  UberSwiftUI
//
//  Created by Kyle Modina on 6/25/24.
//

import SwiftUI

struct TierButton: View {
    let label: String
    
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: .infinity, height: 40) // Adjust the height value as needed
            .cornerRadius(20)
            .overlay(
                Text(label)
                    .foregroundColor(.black)
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            )
            .padding(.horizontal, 10) // Optional: Add padding if needed
    }
}

struct TierButton_Previews: PreviewProvider {
    static var previews: some View {
        TierButton(label: "Sample")
            .previewLayout(.sizeThatFits)
    }
}






