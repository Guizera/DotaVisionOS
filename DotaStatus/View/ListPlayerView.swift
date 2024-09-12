//
//  ListPlayerView.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import SwiftUI

struct ListPlayerView: View {
    let players: [Player]
    @State private var selectedPlayerId: Int?
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(players) { player in
                            Button(action: {
                                selectedPlayerId = player.account_id
                            }) {
                                PlayerCell(avatarPlayer: player.avatarfull, namePlayer: player.personaname)
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Players")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                NavigationLink(destination: navigationDestination, tag: selectedPlayerId ?? 0, selection: $selectedPlayerId) {
                    EmptyView()
                }
            )
        }
    }
    @ViewBuilder
    private var navigationDestination: some View {
        if let playerId = selectedPlayerId {
            PerfilPlayerView(viewModel: DotaViewModel(), playerId: playerId)
        } else {
            EmptyView()
        }
    }
}
struct PlayerContentView: View {
    var body: some View {
        ListPlayerView(players:[ Player(account_id: 88082898, personaname: "Dendi", avatarfull: "https://avatars.steamstatic.com/0b2febdead253dbeed26c68930af541034d003d8_full.jpg", last_match_time: "2024-08-18T15:30:05.000Z", similarity: 24.768902)])
    }
}

#Preview {
    PlayerContentView()
}
