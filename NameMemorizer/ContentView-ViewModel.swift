//
//  ContentView-ViewModel.swift
//  NameMemorizer
//
//  Created by Alex Freddo on 8/4/23.
//

import Foundation
import SwiftUI
import CoreLocation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        
        let locationFetcher = LocationFetcher()
        @Published private(set) var people: [PersonImage]
        @Published private var newImageAlertShown = false
        @Published var person: PersonImage?
        @Published private(set) var location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([PersonImage].self, from: data)
            } catch {
                people = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addPerson(name: String, imgData: Data, location: CLLocationCoordinate2D) {
            people.append(PersonImage(id: UUID(), name: name, image: imgData, lat: location.latitude, long: location.longitude))
            
            save()
        }
    }
}
