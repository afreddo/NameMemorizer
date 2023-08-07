//
//  PersonEditView.swift
//  NameMemorizer
//
//  Created by Alex Freddo on 8/4/23.
//

import SwiftUI
import CoreImage
import MapKit

struct PersonEditView: View {
    @Environment(\.dismiss) var dismiss
    
    var viewModel: ContentView.ViewModel
    @State private var showingPicker = false
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var askForName = false
    @State private var personName = ""
    @State private var location: CLLocationCoordinate2D?
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 150, height: 150)
                
                Text("Tap to select image")
                
                image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            .onTapGesture {
                self.locationFetcher.start()
                showingPicker = true
            }
            
            Spacer()
        }
        .sheet(isPresented: $showingPicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { newImage in
            loadImage()
            askForName = true
        }
        .alert("Add Name", isPresented: $askForName) {
            TextField("Enter name of person", text: $personName)
            Button("OK", role: .cancel) {
                createNewPerson()
                dismiss()
            }
        }
    }
    
    func loadImage() {
         guard let inputImage = inputImage else { return }
         
         image = Image(uiImage: inputImage)
     }
    
    @MainActor func createNewPerson() {
        guard let jpegData = inputImage?.jpegData(compressionQuality: 0.8) else { return }
        location = self.locationFetcher.lastKnownLocation ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        viewModel.addPerson(name: personName, imgData: jpegData, location: location!)
    }
}

