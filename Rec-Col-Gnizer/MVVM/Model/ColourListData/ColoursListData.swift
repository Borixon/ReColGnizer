//
//  FavouriteListData.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

open class ColoursListData: ColourListDataSourceProtocol {
    
    internal var filtered: [ColorModel]?
    
    var data: ColourListDataComponents!
    var navigationTitle: String = ""
    var searchPhrase: String?
    
    init(colourSystem: ColourSystems? = nil) {
        fetchList()
        if let model = data.colourData {
            filtered = sortingType.sort(objects: model)
        }
    }
    
    var sortingType: SortingType = UserData().favouriteSortingType {
        didSet {
            if let model = filtered {
                filtered = sortingType.sort(objects: model)
            }
        }
    }
    
    var emptyList: Bool {
        filtered?.isEmpty ?? true
    }
     
    var numberOfItems: Int {
        filtered?.count ?? 0
    }
    
    func data(forIndex i: Int) -> ColorModel? {
        guard i < filtered?.count ?? 0 else { return nil }
        return filtered?[i]
    }
    
    func fetchList(_ colourSystem: ColourSystems? = nil) {
        
    }
    
    func sort() {
        if let model = filtered {
            filtered = sortingType.sort(objects: model)
        }
    }
    
    func saerch() {
        if searchPhrase == "" || searchPhrase == nil, let model = data.colourData {
            filtered = sortingType.sort(objects: model)
        } else if let phrase = searchPhrase {
            filtered = data.colourData?.filter({ $0.name.value.name.lowercased().contains(phrase.lowercased()) ||
                                                 $0.hex.value.lowercased().contains(phrase.lowercased()) })
            if filtered != nil {
                filtered = sortingType.sort(objects: filtered!)
            }
        }
    }
    
    func search(_ phrase: String?) {
        searchPhrase = phrase
        saerch()
    }
    
    func refreshData() {
        saerch()
        sort()
    }
}
