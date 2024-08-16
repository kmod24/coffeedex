import SwiftUI

struct CoffeeListActivationView: View {
    var body: some View {
        HStack {
            Spacer()
            
            Text("coffee list")
                .foregroundColor(Color(.black))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 100, height: 50)
        .background(
            Rectangle()
                .fill(Color.brown)
                .shadow(color: .black, radius: 6)
        )
    }
}

#Preview {
    NavigationView {
        CoffeeListActivationView()
    }
}
