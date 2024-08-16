import SwiftUI // old

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel

    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                // Main content of the view
                ZStack(alignment: .top) {
                    UberMapViewRepresentable(mapState: $mapState)
                        .ignoresSafeArea()
                    
                    if mapState == .searchingForLocation {
                        LocationSearchView(mapState: $mapState)
                    } else if mapState == .noInput {
                        VStack {
                            LocationSearchActivationView()
                                .padding(.top, 72)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        mapState = .searchingForLocation
                                    }
                                }
                            Spacer() // Add Spacer to push content to top
                        }
                    }
                    
                    MapViewActionButton(mapState: $mapState)
                        .padding(.leading)
                        .padding(.top, 4)
                }
                
                if mapState == .locationSelected || mapState == .polylineAdded {
                    RideRequestView()
                        .transition(.move(edge: .bottom))
                }
                
                if mapState == .noInput {
                    NavigationLink(destination: STierList()) {
                        CoffeeListActivationView()
                            .padding(.bottom, 16)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onReceive(LocationManager.shared.$userLocation) { location in
                if let location = location {
                    locationViewModel.userLocation = location
                }
            }
            .navigationBarHidden(true) // Hide the navigation bar if not needed
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    HomeView()
        .environmentObject(LocationSearchViewModel())
}
