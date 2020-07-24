//
//  FavouriteListData.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

protocol FavouriteListDataDelegate {
    func dataHasChanged()
}

class FavouriteListData: ColoursListData {
    
    var delegate: FavouriteListDataDelegate? = nil
    
    override init(colourSystem: ColourSystems? = nil) {
        super.init()
        CoreDataManager.shared.delegate = self
        navigationTitle = "Favourite list"
        fetchList()
    }
    
    override func fetchList(_ colourSystem: ColourSystems? = nil) {
        CoreDataManager.shared.getColorsList(completion: { model in
            self.data = ColourListDataComponents(colourData: model)
        })
    }
}

extension FavouriteListData: CoreDataManagerDelegate {
    func dataHasChanged() {
        CoreDataManager.shared.getColorsList(completion: { model in
            self.data.colourData = model
            self.refreshData()
            self.delegate?.dataHasChanged()
        })
    }
}

