//
//  LocationsViewModel.swift
//  Mappy
//
//  Created by Erik Valigurský on 18/07/2024.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    // all lodaded locations
    @Published var locations: [Location]
    //curent location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // current region on map
    @Published var mapRegion: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)

    
    // show list of locations
    @Published var showLocationsList: Bool = false
    
    
    // show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            //update mapRegion as MapCameraPosition
            mapRegion = .region(MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan))
        }
    }

    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    func nextButtonPressed() {
      
        // get the current index
//        let currentIndex = locations.firstIndex { location in
//            return location == mapLocation
//        }
//      THIS Constant is the same as constant above !!!!
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else { print("Could not find current index in locations array! Should never happened.")
            return
        }
        
        // chceck if currentIndex is valid.
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // next index is not valid
            // restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}

