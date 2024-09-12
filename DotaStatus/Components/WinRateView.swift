//
//  WinRateView.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import SwiftUI

struct WinRateView: View {
    let win: Int
    let lose: Int
    var winrate: Double {
        let totalgames = win + lose
        return totalgames > 0 ? Double(win) / Double(totalgames) : 0.0
    }
    var body: some View {
        VStack(spacing: 20) {
            Text("Win: \(win) | Lose: \(lose) ")
                .font(.headline)
            VStack {
                Text("Winrate: \(Int(winrate * 100))%")
                ProgressView(value: winrate)
                    .progressViewStyle(LinearProgressViewStyle(tint: .red))
                    .frame(height: 20)
            }
            .padding(.horizontal)
        }
        .padding(30)
    }
}

#Preview {
    WinRateView(win: 1000, lose: 900)
}
