//
//  LocationDetailView.swift
//  Mappy
//
//  Created by Erik Valigurský on 24/07/2024.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    @EnvironmentObject private var vm:LocationsViewModel
    let location: Location

    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                VStack(alignment: .leading, spacing: 16, content: {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayerDetail
                })
                .frame(maxWidth: .infinity,  alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(backButton, alignment: .topLeading)
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!) // LocationDataService can be API in most cases. We have this data about Location hardcoded so it can be safely unwrap like this "!"
        .environmentObject(LocationsViewModel())
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName) // namiesto imageName mozes pouzit $0 a prve imageName in vymazat
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ?  nil : UIScreen.main.bounds.width) // depricated main !!
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        })
    }
    
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)// link is String so we have to make string to URL -- so we create let url (samozrejme je optional tak pridame if pred let)
                    .font(.headline)
                    .tint(.blue)
            }
        })
    }
    private var mapLayerDetail: some View {
        Map(position: $vm.mapRegion) {
            ForEach(vm.locations) { location in
                Annotation(location.id, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0)
                }
            }
        }
                .allowsHitTesting(false)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(30)
    }
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .tint(.primary)
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding()
        }
    }
}
