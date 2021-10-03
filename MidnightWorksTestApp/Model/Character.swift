//
//  Character.swift
//  MidnightWorksTestApp
//
//  Created by Alex Kolsa on 01.10.2021.
//

import Foundation

struct Character: Decodable, Hashable {
    
    var id: Int
    var name: String
    var status: String
    var image: String
    var location: Location
    var episode: [String]
}

struct Location: Decodable, Hashable {
    var name: String
    var url: String
    var residents: [String]?
}

struct Result: Decodable {
    var results: [Character]
}
