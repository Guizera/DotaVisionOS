//
//  DotaViewModel.swift
//  DotaStatus
//
//  Created by José Alves da Cunha on 11/09/24.
//

import Foundation
import Combine

final class DotaViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var playerName: String = ""
    @Published var isLoading: Bool = false
    @Published var profile: ProfileResponse?
    @Published var winLoss: WinLoss?
    @Published var matches: [Match] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func searchPlayer() {
        guard !playerName.isEmpty else { return }
        
        isLoading = true
        let urlString = "https://api.opendota.com/api/search?q=\(playerName)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Player].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print("Error fetching players: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { players in
                self.players = players
            }
            .store(in: &cancellables)
    }
    
    func getProfile(for playerId: String) {
        isLoading = true
        let urlString = "https://api.opendota.com/api/players/\(playerId)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                print("Response data: \(String(data: output.data, encoding: .utf8) ?? "No Data")")
                return output.data
            }
            .decode(type: ProfileResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print("error fetch player profile:\(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] profile in
                self?.profile = profile
                print("ID: \(profile.profile.account_id)")
            }
            .store(in: &cancellables)
    }
    
    func winrate(for playerId: String) {
        isLoading = true
        let urlString = "https://api.opendota.com/api/players/\(playerId)/wl"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> Data in
                print("WINRATE: \(String(data: output.data, encoding: .utf8) ?? "NO DATA")")
                return output.data
            }
            .decode(type: WinLoss.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print("error fetch winrate player: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] winrate in
                self?.winLoss = winrate
                print("win: \(winrate.win)")
                print("lose: \(winrate.lose)")
            }
            .store(in: &cancellables)
    }
    
    func fetchMatches(for playerId: String) {
        let urlString = "https://api.opendota.com/api/players/\(playerId)/matches?limit=20"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Match].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching matches: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] matches in
                self?.matches = matches
            }
            .store(in: &cancellables)
    }
}
