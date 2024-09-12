//
//  PerfilPlayerView.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import SwiftUI

struct PerfilPlayerView: View {
    @StateObject var viewModel: DotaViewModel
    let playerId: Int
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer()
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let profilePlayer = viewModel.profile {
                    HStack(spacing: 30) {
                        AsyncImage(url: URL(string: viewModel.profile?.profile.avatarmedium ?? ""))
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .padding(.all, 10)
                        
                        Text(profilePlayer.profile.personaname)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        MedalView(rankTier: profilePlayer.rank_tier)
                    }
                    WinRateView(win: viewModel.winLoss?.win ?? 0, lose: viewModel.winLoss?.lose ?? 0)
                    Text("Last 20 Matches")
                        .font(.headline)
                        .padding(.top)
                    
                    LazyVStack {
                        ForEach(viewModel.matches) { match in
                            MatchesView(heroId: match.hero_id, averageRank: match.averageRank, kill: match.kills, death: match.deaths, assist: match.assists)
                            
                        }
                    }
                    .padding(.all, 20)
                }
            }
            .onAppear{
                viewModel.getProfile(for: "\(playerId)")
                viewModel.winrate(for: "\(playerId)")
                viewModel.fetchMatches(for: "\(playerId)")
            }
        }
    }
}


#Preview {
    PerfilPlayerView(viewModel: DotaViewModel(), playerId: 275745206)
}
