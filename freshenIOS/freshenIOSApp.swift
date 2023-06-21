//
//  freshenIOSApp.swift
//  freshenIOS
//
//  Created by Klay Anthony Clarke on 6/21/23.
//

import SwiftUI

@main
struct freshenIOSApp: App {
    @StateObject var mapViewModel: MapViewModel = MapViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mapViewModel)
        }
    }
}
