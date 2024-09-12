//
//  DotaResponse.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import Foundation

struct Player: Identifiable, Codable, Equatable {
    let account_id: Int
    let personaname: String
    let avatarfull: String
    let last_match_time: String?
    let similarity: Double?
    
    var id: Int { account_id }
    
    enum CodingKeys: String, CodingKey {
        case account_id
        case personaname
        case avatarfull
        case last_match_time
        case similarity
    }
}

struct Profile: Codable {
    let playerProfile: ProfileResponse
    let winLoss: WinLoss
}

struct ProfileResponse: Codable {
    let profile: ProfilePlayer
    let rank_tier: Int?
    let leaderboard_rank: Int?
}

struct ProfilePlayer: Codable {
    let account_id: Int
    let personaname: String
    let avatar: String
    let avatarmedium: String
    let avatarfull: String
    let steamid: String
    let profileurl: String
    let last_login: String?
    let loccountrycode: String?
    let status: String?
    let fh_unavailable: Bool
    let is_contributor: Bool
    let is_subscriber: Bool
}

struct WinLoss: Codable {
    let win: Int
    let lose: Int
    
    enum CodingKeys: String, CodingKey {
        case win
        case lose
    }
}
struct Match: Codable, Identifiable {
    let id = UUID()
    let match_id: Int
    let radiant_win: Bool
    let duration: Int
    let start_time: Int
    let hero_id: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let party_size: Int?
    let averageRank: Int
    
    enum CodingKeys: String, CodingKey {
        case match_id
        case radiant_win
        case duration
        case start_time
        case hero_id
        case kills
        case deaths
        case assists
        case party_size
        case averageRank = "average_rank"
    }
}

