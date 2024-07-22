//
//  MappyApp.swift
//  Mappy
//
//  Created by Erik Valigurský on 18/07/2024.
//

import SwiftUI

@main
struct MappyApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
