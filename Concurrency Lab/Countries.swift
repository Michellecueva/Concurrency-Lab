//
//  File.swift
//  Concurrency Lab
//
//  Created by Michelle Cueva on 9/3/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

enum JSON: Error {
    case decodingError(Error)
}

struct Country: Codable {
    let name: String
    let capital: String
    let population: Int
    let flag: String
    
    static func getDataInfo(data: Data) throws -> [Country] {
        do {
            let country = try
                JSONDecoder().decode([Country].self, from: data)
            return country
        } catch {
            throw JSON.decodingError(error)
        }
    }
    
    static func getFilteredResults(arr: [Country], searchText: String) -> [Country] {
        var currentFilter: [Country]
        currentFilter = arr.filter{$0.name.lowercased().contains(searchText.lowercased())}
        return currentFilter
    }
    
}
