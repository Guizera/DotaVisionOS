//
//  PlayerCell.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import SwiftUI

struct PlayerCell: View {
    var avatarPlayer: String
    var namePlayer: String
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: avatarPlayer)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
                    .clipShape(Circle())
                    .padding(.all, 10)
            } placeholder: {
                ProgressView()
            }
            
            Text(namePlayer)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 70, alignment: .leading)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct ComponentView: View {
    @State var namePlayer = "Teste Player"
    var body: some View {
        List {
            PlayerCell(avatarPlayer: "https://avatars.steamstatic.com/0b2febdead253dbeed26c68930af541034d003d8_full.jpg", namePlayer: namePlayer)
        }
    }
}

#Preview {
    ComponentView()
}
