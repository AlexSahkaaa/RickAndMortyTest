//
//  DetailViewModel.swift
//  MidnightWorksTestApp
//
//  Created by Alex Kolsa on 03.10.2021.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    
    @Published var currentLocationCharacters: [Character] = []
    @Published var choosedCharacter: Character
    
    init(locationName: String, choosedCharacter: Character) {
        self.choosedCharacter = choosedCharacter
        
        fetchCurrentLocationCharaters(locationName: locationName) { characters in
            characters.forEach { characterUrl in
                guard let url = URL(string: characterUrl) else { return }
                
                URLSession.shared.dataTask(with: url) { (data, resp, err) in
                    
                    DispatchQueue.main.async {
                        guard let data = data else { return }
                        do {
                            let character = try JSONDecoder().decode(Character.self, from: data)
                            self.currentLocationCharacters.append(character)
                        } catch {
                            print("Failed to decode JSON:", error)
                        }
                    }
                    
                }.resume()
            }
        }
    }
    
    func fetchCurrentLocationCharaters(locationName: String, callback: @escaping ([String]) -> ()) {
        guard let url = URL(string: locationName) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let location = try JSONDecoder().decode(Location.self, from: data)
                    callback(location.residents ?? [])
                } catch {
                    print("Failed to decode JSON:", error)
                }
            }
            
        }.resume()
    }
    
}
