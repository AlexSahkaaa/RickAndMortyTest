//
//  ViewModel.swift
//  MidnightWorksTestApp
//
//  Created by Alex Kolsa on 01.10.2021.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var result: Result?
//    @Published var isLoading: Bool = true
    @Published var firstSeenIn: String = ""
    
    static let access = MainViewModel()
    
    func fetchAllCharacters() {
        let urlString = "https://rickandmortyapi.com/api/character"
        
        guard let url = URL(string: urlString) else {
//            self.isLoading = false
            return
        }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
//                self.isLoading = false
                return
            }
            
            DispatchQueue.main.async {
                
                guard let data = data else { return }
                
                do {
                    self.result = try JSONDecoder().decode(Result.self, from: data)
                } catch {
                    print("Failed to decode JSON:", error)
                }
                
//                self.isLoading = false
            }
        }.resume()
    }
    
    func fetchFirstSeenEpisode(url: String, callback: @escaping (String) -> ()) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let episode = try JSONDecoder().decode(Episode.self, from: data)
                    callback(episode.name)
                } catch {
                    print("Failed to decode JSON:", error)
                }
            }
            
        }.resume()
    }
    
}
