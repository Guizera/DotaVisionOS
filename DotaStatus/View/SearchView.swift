//
//  SearchView.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: DotaViewModel
    @State private var path = NavigationPath()
    @State private var playerName = "Dendi"
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack(spacing: 50) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width:100)
                    TextField("Player Name", text: $viewModel.playerName)
                        .padding()
                        .background()
                        .cornerRadius(10.0)
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .frame(width: 500)
                    Button {
                        viewModel.searchPlayer()
                    } label: {
                        Text("Search Player")
                            .foregroundStyle(.white)
                            .padding()
                            
                    }
                    if viewModel.isLoading {
                        ProgressView()
                            .foregroundStyle(.white)
                    }
                }
                .padding()
            }
            .onChange(of: viewModel.players) { oldValue, newValue in
                if !newValue.isEmpty {
                    path.append("ListPlayerView")
                }
            }
            .navigationDestination(for: String.self) { view in
                if view == "ListPlayerView" {
                    ListPlayerView(players: viewModel.players)
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    SearchView(viewModel: DotaViewModel())
}
