import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var manager = LocationManager()
    
    @State var trackingMode = MapUserTrackingMode.follow
    @State var searchText = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.purpleCustom.edgesIgnoringSafeArea(.all)
            Map(coordinateRegion: $manager.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $trackingMode)
            .edgesIgnoringSafeArea(.top)
            
            VStack {
                TextField("Search", text: $searchText, onCommit: {
                    search()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Spacer()
                
                Button(action: {
                    trackingMode = MapUserTrackingMode.follow
                }) {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width:35 ,height: 35)
                        .padding(7)
                        .background(Color.purpleCustom)
                        .foregroundColor(.pinkCustom)
                        .cornerRadius(10)
                }
                .padding(10)
            }
            
        }
    }
    
    func search() {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else { return }
            
            if let item = response.mapItems.first {
                let coordinate = item.placemark.coordinate
                manager.region.center = coordinate
                trackingMode = MapUserTrackingMode.none
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

