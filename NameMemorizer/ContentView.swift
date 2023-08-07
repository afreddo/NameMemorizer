//
//  ContentView.swift
//  NameMemorizer
//
//  Created by Alex Freddo on 8/4/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State private var image: Image?
    @State private var preimage: UIImage?
    
    var body: some View {
        NavigationView {
            List {
                ForEach (viewModel.people.sorted()) { person in
                    HStack {
                        NavigationLink {
                            PhotoDetailView(personPassed: person)
                        } label: {
                            person.convert()
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width:100, height:100)
                            Spacer()
                            Text(person.name)
                        }
                        
                        
                    }
                }
            }
            .navigationTitle("NameMemorizer")
            .toolbar {
                NavigationLink {
                    PersonEditView(viewModel: viewModel)
                } label: {
                    Image(systemName: "plus")
                }
            }
            .onChange(of: viewModel.people) { person in
                
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
