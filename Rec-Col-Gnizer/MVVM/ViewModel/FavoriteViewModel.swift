//
//  FavoriteViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class FavoriteViewModel: NSObject {

    let cellIdentifier = "ColorCellIdentifier"
    private var dataModel: [(String, String)] = []
    
    var numberOfRows: Int {
        return dataModel.count
    }
    
    override init() {
        
    }
    
    func refreshData() {
        if let data = CoreDataManager.shared.getColorsList() {
            dataModel = data
        } else {
            dataModel.removeAll()
        }
    }
    
    func data(forIndex i: Int) -> (name: String, hex: String)? {
        if i < dataModel.count {
            return dataModel[i]
        } else {
            return nil
        }
    }

}
