//
//  PickerViewController+SearchBar.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

extension PickerViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let hex = searchBar.text else { return }
        hideKeyboard() 
        vm.search(hex: hex)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        revelKeyboard()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        hideKeyboard()
        searchBar.text = nil
    }
}

extension PickerViewController {
    internal func hideKeyboard() {
        searchBar.setShowsCancelButton(false, animated: true)
        view.endEditing(true)
    }
    
    internal func revelKeyboard() {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
