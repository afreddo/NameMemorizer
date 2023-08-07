//
//  PhotoDetailView.swift
//  NameMemorizer
//
//  Created by Alex Freddo on 8/7/23.
//

import SwiftUI
import MapKit

struct PhotoDetailView: View {
    @State var showImageLocation: Bool
    @State var mapRegion: MKCoordinateRegion
    var person: PersonImage
    
    
    init(personPassed: PersonImage) {
        person = personPassed
        showImageLocation = false
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    }
    
    var body: some View {
        VStack {
            if showImageLocation {
                ZStack {
                    Map(coordinateRegion: $mapRegion)
                    Circle()
                        .fill(.red)
                        .frame(width: 15)
                }
            } else {
                person.convert()
                    .resizable()
                    .scaledToFill()
            }
            Toggle("Show image location", isOn: $showImageLocation)
        }
        .navigationTitle(person.name)
    }
}

