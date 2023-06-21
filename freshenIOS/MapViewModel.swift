//
//  MapViewModel.swift
//  freshenIOS
//
//  Created by Klay Anthony Clarke on 6/21/23.
//

import SwiftUI
import MapKit

class MapViewModel: ObservableObject {
    // All salons
    @Published var salons: [SalonElement] = []
    
    @Published var headerSalonName: String = ""
    
    @Published var sortBy: Sorter = Sorter.alphabetically
    
    // Current salon center in map
    @Published var mapSalon: SalonElement? {
        didSet {
            if mapSalon != nil {
                updateMapRegion(salon: mapSalon!)
                headerSalonName = mapSalon!.name
            } else {
                headerSalonName = ""
            }
        }
    }
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    
    // Show list of salons (explore page)
    @Published var showSalonsList: Bool = false
    
    init() {
        // fetch and save data
        self.fetchSalons()
    }
    
    private func updateMapRegion(salon: SalonElement) {
        withAnimation(.easeInOut) {
            self.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: salon.geometry.coordinates[1], longitude: salon.geometry.coordinates[0]), span: mapSpan)
        }
    }
    
    private func fetchSalons() {
        guard let url = URL(string: "https://freshenv3.vercel.app/api/salons/get".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let apiReturnElement = try JSONDecoder().decode(ApiReturnElement.self, from: data) as ApiReturnElement
                var salons = apiReturnElement.features as [SalonElement]
                
                DispatchQueue.main.async {
                    self?.salons = salons
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            self.showSalonsList.toggle()
        }
    }
    
    func showNextLocation(salon: SalonElement) {
        withAnimation(.easeInOut) {
            self.mapSalon = salon
            self.showSalonsList = false
        }
    }
}
