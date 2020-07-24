//
//  FavouriteViewController+SearchBar.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 17/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

extension ColourListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        vm.setSearchPhrase(searchBar.text)
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.setSearchPhrase(searchText)
        tableView.reloadData()
    }
}
