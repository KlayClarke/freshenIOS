//
//  ContentView.swift
//  freshenIOS
//
//  Created by Klay Anthony Clarke on 6/21/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mapViewModel: MapViewModel
    var body: some View {
        VStack {
            List {
                ForEach(mapViewModel.salons) { salon in
                    Text(salon.name)
                }
            }
        }
        .padding()
        let _ = print(mapViewModel.salons)
    }
}

#Preview {
    ContentView()
        .environmentObject(MapViewModel())
}
