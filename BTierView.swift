import SwiftUI

struct BTierView: View {
    // Unique key for BTierView
    @AppStorage("bTierCoffeeViews") private var coffeeViewsData: Data = Data()
    @State private var coffeeViews: [CoffeeViewData] = []

    init() {
        let defaultViews = [
            CoffeeViewData(title: "Coffee View 1"),
            CoffeeViewData(title: "Coffee View 2"),
            CoffeeViewData(title: "Coffee View 3")
        ]
        
        if let decodedViews = try? JSONDecoder().decode([CoffeeViewData].self, from: coffeeViewsData) {
            _coffeeViews = State(initialValue: decodedViews)
        } else {
            _coffeeViews = State(initialValue: defaultViews)
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.3))
                .frame(width: 375, height: 620)

            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                        ForEach(coffeeViews) { data in
                            NavigationLink(destination: CoffeeInputView(identifier: data.id.uuidString)) {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.white)
                                    .frame(width: 170, height: 150)
                                    .shadow(radius: 10)
                                    .padding()
                                    .overlay(
                                        Text(data.title)
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.center)
                                    )
                            }
                        }
                    }
                    .padding()
                }
                .frame(width: 390, height: 600)
                .clipped()
            }
            .padding()

            GeometryReader { geo in
                HStack {
                    Button(action: {
                        removeCoffeeView()
                    }, label: {
                        Image("minussymbol")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding(.leading, 20)
                            .padding(.top, -30)
                    })

                    Spacer()

                    Button(action: {
                        addCoffeeView()
                    }, label: {
                        Image("plus")
                            .resizable()
                            .frame(width: 40, height: 40)
                    })
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .bottomTrailing)
                .alignmentGuide(HorizontalAlignment.center) { d in d[HorizontalAlignment.center] }
                .padding(.top, 20)
            }
        }
        .padding()
        .navigationBarHidden(true)
    }

    private func addCoffeeView() {
        let newIndex = coffeeViews.count + 1
        coffeeViews.append(CoffeeViewData(title: "Coffee View \(newIndex)"))
        saveViews()
    }
    
    private func removeCoffeeView() {
        if !coffeeViews.isEmpty {
            coffeeViews.removeLast()
            saveViews()
        }
    }

    private func saveViews() {
        if let encodedViews = try? JSONEncoder().encode(coffeeViews) {
            coffeeViewsData = encodedViews
        }
    }
}

struct BTierView_Previews: PreviewProvider {
    static var previews: some View {
        BTierView()
    }
}
