//
//  MedalView.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import SwiftUI

struct MedalView: View {
    let rankTier: Int?
    var body: some View {
        if let rankTier = rankTier {
            Image(medalImageName(for: rankTier))
                .resizable()
                .scaledToFit()
                .frame(width: 100)
        } else {
            Image("noRank")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
        }
    }
    private func medalImageName(for rankTier: Int) -> String {
        return "medal\(rankTier)"
    }
}

#Preview {
    MedalView(rankTier: 80)
}
