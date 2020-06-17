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
    
    private func setupSearchBar() {
//        let searchBar = UISearchBar()
//        searchBar.sizeToFit()
//        searchBar.setShowsCancelButton(false, animated: false)
//        searchBar.returnKeyType = .search
//        searchBar.placeholder = "vm.placeholder"
//
//        if #available(iOS 13.0, *) {
//            searchBar.searchTextField.backgroundColor = Style.keyColor
//            searchBar.searchTextField.textColor = Style.keyContrastColor
//            if let icon = searchBar.searchTextField.leftView as? UIImageView {
//                let newImage = icon.image?.withTintColor(Style.accentKeyColor, renderingMode: .alwaysTemplate)
//                searchBar.searchTextField.leftView = UIImageView(image: newImage)
//            }
//        } else if let _ = searchBar.value(forKey: "searchField") as? UITextField {
//
//        }
//
//        searchBar.tintColor = Style.accentKeyColor
//        searchBar.backgroundImage = UIImage()
//
//        let leftNavBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
//        navigationController?.navigationItem.leftBarButtonItem = leftNavBarButton
//        navigationController?.navigationItem.titleView = searchBar
//        navigationController?.navigationBar.barTintColor = .white
//        definesPresentationContext = true
    }
    
    public func setTitle(_ string: String) {
        
    }
    
}
