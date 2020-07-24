//
//  FavoriteViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ColourListViewModel: ColourListViewModelProtocol {
    let nibName = "ColorCell"
    let cellIdentifier = "ColorCellIdentifier"
    let placeholder = "Search name or hex"
    
    var data: ColourListDataSourceProtocol!
    
    var sortingType: SortingType {
        get {
            data.sortingType
        }
        set {
            data.sortingType = newValue
        }
    }
    
    
    var navigationTitle: String {
        data.navigationTitle
    }
    
    var infoText: String {
//        if colourData == nil || colourData?.isEmpty ?? true {
            return "Oh no!\nYou have no favorite colors yet!"
//        } else {
//            return "No colour for searching phrase!"
//        }
    }
     
    var colorArrayIsEmpty: Bool {
        data.emptyList
    }
    
    var numberOfItems: Int {
        data.numberOfItems
    }
    
    func setSearchPhrase(_ phrase: String?) {
        data.search(phrase)
    }
    
//    func filterColours() {
//        guard let phrase = searchPhrase?.lowercased() else { return }
//        colours = colourData?.filter({ $0.name.value.name.lowercased().contains(phrase) ||
//                                        $0.hex.value.lowercased().contains(phrase) })
//    }
    
    func reloadData() {
//        if self.searchPhrase?.isEmpty ?? true {
//            self.colours = self.colourData
//        } else {
//            self.filterColours()
//        }
//        sort()
    }
    
    func setSorting(_ sortingType: SortingType, completion: @escaping () -> ()) {
        data.sortingType = sortingType
        reloadData()
        completion()
    }
    
    func refreshData() {
//        TODO:
//        DataManager.shared.getColorsList(completion: { data in
//            self.colourData = data
//            self.reloadData()
//        })
    }
    
    func data(forIndex i: Int) -> (label1: String, label2: String, colour: UIColor)? {
        if let model = data.data(forIndex: i) {
            if sortingType == .hexAscending || sortingType == .hexDescending {
                return (model.hex.value, model.name.value.name, model.color)
            } else {
                return (model.name.value.name, model.hex.value, model.color)
            }
        }
        return nil
    }
    
    func getColorModel(forIndex i: Int, completion: @escaping (ColorModel?) -> ()) {
         completion(data.data(forIndex: i) )
    }
}
