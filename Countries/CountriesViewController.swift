//
//  CountriesViewController.swift
//  Countries
//
//  Created by Daniel Pietsch on 4/25/25.
//

import UIKit

class CountriesViewController: UIViewController {
    private lazy var presenter = {
        CountriesPresenter(view: self)
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    private var countries: [Country] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Countries"
        
        self.searchController.searchResultsUpdater = self
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.presenter.fetchCountries()
    }
}


extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.presenter.search(for: searchController.searchBar.text)
    }
}


extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseIdentifier, for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        let country = self.countries[indexPath.row]
        
        cell.name.text = "\(country.name), \(country.region)"
        cell.capital.text = country.capital
        cell.code.text = country.code
        
        return cell
    }
}


extension CountriesViewController: UITableViewDelegate {
}


extension CountriesViewController: CountriesViewDelegate {
    func showLoading() {
        self.contentUnavailableConfiguration = UIContentUnavailableConfiguration.loading()
    }
    
    func show(countries: [Country]) {
        self.contentUnavailableConfiguration = nil
        self.countries = countries
    }
    
    func show(error: Error) {
        var config = UIContentUnavailableConfiguration.empty()
        config.image = UIImage(systemName: "x.circle.fill")
        config.text = "Error"
        config.secondaryText = error.localizedDescription

        self.contentUnavailableConfiguration = config
    }
}

