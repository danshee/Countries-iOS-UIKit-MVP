# Countries Search

## Summary

This project is an iOS app that fetches a list of countries and allows the user to search those countries by country name or capital name.

The code is implemented in Swift and UIKit.

The architecture is the MVP pattern (i.e. Model-View-Presenter).

## Architecture


`CountriesPresenter`

This is the *presenter* part of the architecture.

It is responsible for fetching data from the network and filtering that data based on search criteria.


`CountriesViewController`

This is the *view* part of the architecture.

This is the UIKit view controller used to display the country data and capture user actions (including the search bar).

Display data is taken from and user actions are sent to the `CountriesPresenter`.


`CountriesViewDelegate`

Abstract protocol that `CountriesPresenter` operates upon.  `CountriesViewController` conforms to this.


`Country`

This is the *model* part of the architecture.

It represents one country.


`CountryTableViewCell`

This is a `UITableViewCell`-derived custom cell type used to display country data.


`Network`

This is the network layer that implements fetching country data.
