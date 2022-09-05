//
//  MapAdventuresApp.swift
//  MapAdventures
//
//  Created by yaaburnee on 05/09/22.
//

import SwiftUI

@main
struct MapAdventuresApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
