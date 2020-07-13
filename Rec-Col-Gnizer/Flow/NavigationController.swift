//
//  NavigationController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 04/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    init() {
        super.init(navigationBarClass: nil, toolbarClass: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public var sortingItem: UIBarButtonItem {
        let sortingIcon = UIImage(named: "SortIcon")?.withRenderingMode(.alwaysTemplate)
        let sortingItem = UIBarButtonItem(image: sortingIcon, style: .plain, target: self, action: nil)
        sortingItem.tintColor = Style.accentColor
        
        return sortingItem
    }
    
    public var searchBar: UISearchBar {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.returnKeyType = .search
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = Style.keyColor
            searchBar.searchTextField.textColor = Style.keyContrastColor
            if let icon = searchBar.searchTextField.leftView as? UIImageView {
                let newImage = icon.image?.withTintColor(Style.accentKeyColor, renderingMode: .alwaysTemplate)
                searchBar.searchTextField.leftView = UIImageView(image: newImage)
            }
        } else if let _ = searchBar.value(forKey: "searchField") as? UITextField {
            
        }
        
        searchBar.tintColor = Style.accentKeyColor
        searchBar.backgroundImage = UIImage()
        
        return searchBar
    }
    
    public func setupSortingButton() {
        
    } 
}
