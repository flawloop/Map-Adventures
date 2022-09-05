//
//  LocationsViewModel.swift
//  MapAdventures
//
//  Created by yaaburnee on 05/09/22.
//

import Foundation

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
}
