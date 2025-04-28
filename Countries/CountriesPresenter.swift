//
//  CountriesPresenter.swift
//  Countries
//
//  Created by Daniel Pietsch on 4/25/25.
//

import Foundation

class CountriesPresenter {
    private weak var viewDelegate: CountriesViewDelegate?
    
    private let network = Network()
    
    private var countries: [Country] = []
    
    init(view: CountriesViewDelegate) {
        self.viewDelegate = view
    }
    
    func fetchCountries() {
        self.viewDelegate?.showLoading()
        
        Task { @MainActor in
            do {
                self.countries = try await self.network.fetchCountries()
                self.viewDelegate?.show(countries: self.countries)
            }
            catch {
                self.viewDelegate?.show(error: error)
            }
        }
    }
    
    func search(for prefix: String?) {
        if let prefix = prefix {
            let filteredCountries = self.countries.filter { country in
                return country.name.starts(with:prefix) || country.capital.starts(with:prefix)
            }
            
            self.viewDelegate?.show(countries: filteredCountries)
        } else {
            self.viewDelegate?.show(countries: self.countries)
        }
    }
}
