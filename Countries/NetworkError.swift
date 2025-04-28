//
//  NetworkError.swift
//  Countries
//
//  Created by Daniel Pietsch on 4/25/25.
//


import Foundation

fileprivate let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"

enum NetworkError: Error {
    case badUrl(String)
    case badResponse(URLResponse)
}

class Network {
    func fetchCountries() async throws -> [Country] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl(urlString)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badResponse(response)
        }

        let countries = try JSONDecoder().decode([Country].self, from: data)
        
        return countries
    }
}
