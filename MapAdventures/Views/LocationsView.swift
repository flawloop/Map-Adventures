//
//  LocationsView.swift
//  MapAdventures
//
//  Created by yaaburnee on 05/09/22.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIPad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer()
            VStack(spacing: 0) {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIPad)
                Spacer()
                locationsPreviewStack()
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    
    private var header: some View {
            VStack {
                Button {
                    vm.toggleLocationsList()
                } label: {
                    Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
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
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
}

struct mapLayer: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations ,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 7)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
        .edgesIgnoringSafeArea(.all)
    }
}

struct locationsPreviewStack: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIPad: CGFloat = 700
    
    var body: some View {
        ZStack{
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationsPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIPad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
