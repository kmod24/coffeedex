//
//  FTierList.swift
//  UberSwiftUI
//
//  Created by Kyle Modina on 6/25/24.
//

import SwiftUI

struct FTierList: View {
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: HomeView()) {
                    CoffeeBackButton()
                        .padding(.leading, 20)
                        .padding(.top, 60)
                }
                
                Spacer()
                
                Text("F Tier")
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .padding(.top, 70)
                    .padding(.trailing, 50)
                
                Spacer()
            }
            
            FTierView()
                .padding(.top, 1)
            
            Spacer()
            
            HStack(spacing: 10) {
                NavigationLink(destination: STierList()) {
                    TierButton(label: "S")
                }
                NavigationLink(destination: ATierList()) {
                    TierButton(label: "A")
                }
                NavigationLink(destination: BTierList()) {
                    TierButton(label: "B")
                }
                NavigationLink(destination: CTierList()) {
                    TierButton(label: "C")
                }
                    TierButton(label: "F")
            }
            .padding(.top, 1)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(Color.customBackgroundColor)
        }
        .background(Color.customBackgroundColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct FTierList_Previews: PreviewProvider {
    static var previews: some View {
        FTierList()
    }
}
