import SwiftUI
import Combine

struct CoffeeInputView: View {
    let identifier: String
    
    @AppStorage("coffeePlace") private var coffeePlace: String = ""
    @AppStorage("textFields") private var textFieldsData: Data = Data()
    @AppStorage("ratings") private var ratingsData: Data = Data()
    @State private var coffeeRating: String = ""
    @State private var selectedImages: [UIImage?] = Array(repeating: nil, count: 10) {
        didSet {
            saveImages()
        }
    }
    @State private var textFields: [String] = Array(repeating: "", count: 10)
    @State private var ratings: [String] = Array(repeating: "", count: 10)
    @State private var showingImagePicker = false
    @State private var currentIndex: Int? = nil

    var body: some View {
        NavigationView {
            VStack(spacing: 5) {
                Spacer().frame(height: 10)
                TextField("Insert Coffee Place here", text: $coffeePlace)
                    .padding()
                    .frame(width: 400, height: 60)
                    .multilineTextAlignment(.center)
                    .onChange(of: coffeePlace) { _ in saveCoffeePlace() }
                
                Text("menu")
                
                Spacer().frame(height: 10)
                
                DashedDivider()
                
                Spacer().frame(height: 10)
                
                HStack {
                    Spacer().frame(width: 25)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(0..<10, id: \.self) { index in
                                HStack {
                                    ZStack {
                                        if let image = selectedImages[index] {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                        } else {
                                            Rectangle()
                                                .fill(Color.brown)
                                                .frame(width: 100, height: 100)
                                        }
                                    }
                                    .onTapGesture {
                                        currentIndex = index
                                        showingImagePicker = true
                                    }
                                    .padding(.vertical, 5)
                                    
                                    TextView(text: $textFields[index])
                                        .frame(width: 150, height: 100)
                                        .border(Color.gray, width: 1)
                                        .onChange(of: textFields) { _ in saveTextFields() }
                                    
                                    TextView(text: $ratings[index])
                                        .frame(width: 90, height: 100)
                                        .border(Color.gray, width: 1)
                                        .onChange(of: ratings) { _ in saveRatings() }
                                }
                            }
                        }
                    }
                    .frame(width: 350)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showingImagePicker) {
                if let index = currentIndex {
                    ImagePicker(image: Binding(
                        get: { selectedImages[index] },
                        set: { newImage in
                            selectedImages[index] = newImage
                        }
                    ))
                }
            }
        }
        .onAppear {
            loadCoffeePlace()
            loadImages()
            loadTextFields()
            loadRatings()
        }
    }
    private func saveCoffeePlace() {
        UserDefaults.standard.set(coffeePlace, forKey: "coffeePlace_\(identifier)")
    }
    
    private func loadCoffeePlace() {
        coffeePlace = UserDefaults.standard.string(forKey: "coffeePlace_\(identifier)") ?? ""
    }
    
    private func saveImages() {
        let imageDataArray = selectedImages.compactMap { $0?.jpegData(compressionQuality: 1.0) }
        UserDefaults.standard.set(imageDataArray, forKey: "selectedImages_\(identifier)")
    }
    
    private func loadImages() {
        if let imageDataArray = UserDefaults.standard.array(forKey: "selectedImages_\(identifier)") as? [Data] {
            selectedImages = imageDataArray.map { UIImage(data: $0) }
        }
    }
    
    private func saveTextFields() {
        if let data = try? JSONEncoder().encode(textFields) {
            UserDefaults.standard.set(data, forKey: "textFields_\(identifier)")
        }
    }
    
    private func loadTextFields() {
        if let data = UserDefaults.standard.data(forKey: "textFields_\(identifier)"),
           let loadedTextFields = try? JSONDecoder().decode([String].self, from: data) {
            textFields = loadedTextFields
        }
    }
    
    private func saveRatings() {
        if let data = try? JSONEncoder().encode(ratings) {
            UserDefaults.standard.set(data, forKey: "ratings_\(identifier)")
        }
    }
    
    private func loadRatings() {
        if let data = UserDefaults.standard.data(forKey: "ratings_\(identifier)"),
           let loadedRatings = try? JSONDecoder().decode([String].self, from: data) {
            ratings = loadedRatings
        }
    }
}

struct DashedDivider: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: width, y: 0))
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(.black)
        }
        .frame(height: 1)
        .padding(.horizontal, 20)
    }
}

struct CoffeeInputView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeInputView(identifier: UUID().uuidString)
    }
}
