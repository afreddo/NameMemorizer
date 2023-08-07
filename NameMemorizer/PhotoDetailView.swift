//
//  PhotoDetailView.swift
//  NameMemorizer
//
//  Created by Alex Freddo on 8/7/23.
//

import SwiftUI
import MapKit

struct PhotoDetailView: View {
    @State private var showImageLocation: Bool
    @State private var mapRegion: MKCoordinateRegion
    var person: PersonImage
    
    
    init(personPassed: PersonImage) {
        person = personPassed
        _showImageLocation = State(initialValue: false)
        _mapRegion = State(initialValue: MKCoordinateRegion(center: person.currentLocation(), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)))
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

