//
//  MatchesView.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import SwiftUI

struct MatchesView: View {
    var heroId: Int
    var averageRank: Int?
    var kill: Int
    var death: Int
    var assist: Int
    var body: some View {
        HStack(spacing: 20) {
            Image(heroImageName(for: heroId))
                .resizable()
                .scaledToFit()
                .frame(width: 70)
                .padding(.all, 10)
            
            Text("\(kill) / \(death) / \(assist)")
                .font(.system(size: 24, weight: .bold))
                .frame(alignment: .center)
                .padding(10)
            
            Spacer()
            if let averageRank = averageRank {
                Image(medalImageName(for: averageRank))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, alignment: .trailing)
                    .padding(10)
            } else {
                Image("noRank")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, alignment: .trailing)
                    .padding(10)
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 70, alignment: .leading)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    func heroImageName(for heroId: Int) -> String {
        return "hero\(heroId)"
    }
    
    func medalImageName(for averageRank: Int) -> String {
        return "medal\(averageRank)"
    }
}

struct MatchesContentView: View {
    var body: some View {
        List {
            MatchesView(heroId: 20, averageRank: 51, kill: 12, death: 3, assist: 10)
        }
    }
}

#Preview {
    MatchesContentView()
}
