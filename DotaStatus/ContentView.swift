//
//  ContentView.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        SearchView(viewModel: DotaViewModel())
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
