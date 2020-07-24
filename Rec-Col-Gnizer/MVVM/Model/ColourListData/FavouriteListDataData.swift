//
//  FavouriteListData.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

final class ColoursListDataData: ColourListDataSourceProtocol {
    
    var data: ColourListDataComponents!
    var navigationTitle: String = ""
    
    init(colourSystem: ColourSystems? = nil) {
        self.fetchList()
    }
     
    var numberOfItems: Int {
        data.numberOfItems
    }
    
    func fetchList(_ colourSystem: ColourSystems? = nil) {
        CoreDataManager.shared.getColorsList(completion: { model in
            self.data = ColourListDataComponents(colourData: model)
        })
    }
    
    func search(_ phrase: String) {
        data.setSearchPhrase(phrase)
    }
}
