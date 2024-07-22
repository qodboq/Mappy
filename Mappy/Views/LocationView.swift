//
//  LocationView.swift
//  Mappy
//
//  Created by Erik Valigurský on 18/07/2024.
//

import SwiftUI
import MapKit



struct LocationView: View {

    @EnvironmentObject private var vm: LocationsViewModel
    var body: some View {
        ZStack {
            Map(position: $vm.mapRegion)
            
            VStack() {
                header
                .padding()
                Spacer()
                
                ZStack {
                    ForEach(vm.locations) { location in
                        if vm.mapLocation == location {
                            LocationPreviewView(location: location)
                                .shadow(color: .black.opacity(0.8), radius: 20, x: 0.0, y: 0.0)
                                .padding()
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)))
                        }
                    
                    }
                }
            }
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationsViewModel())
}

extension LocationView {
    private var header: some View {
        VStack {
            Button(action: vm.toggleLocationList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .tint(.primary)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }
            
            if vm.showLocationsList {
                LocationsListView()
            }
           
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.8), radius: 20, x: 0, y: 15)
    }
}
