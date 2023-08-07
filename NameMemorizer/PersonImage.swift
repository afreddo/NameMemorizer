//
//  PersonImage.swift
//  NameMemorizer
//
//  Created by Alex Freddo on 8/4/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct PersonImage: Hashable, Identifiable, Codable, Comparable {
    let id: UUID
    let name: String
    let image: Data
    var lat: Double = 0.0
    var long: Double = 0.0
    
    func currentLocation() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    func convert() -> Image {
            let uiImageData = image
            if let uiImage = UIImage(data: uiImageData) {
                return Image(uiImage: uiImage)
            }
            return Image(systemName: "questionmark.square.dashed")
        }
    
    static func <(lhs: PersonImage, rhs: PersonImage) -> Bool {
        lhs.name < rhs.name
    }
}
