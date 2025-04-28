//
//  CountriesViewDelegate.swift
//  Countries
//
//  Created by Daniel Pietsch on 4/25/25.
//


import Foundation

protocol CountriesViewDelegate: AnyObject {
    func showLoading()
    func show(countries: [Country])
    func show(error: Error)
}
