//
//  FavoriteViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

protocol FavouriteViewModelDelegate {
    func openColor(_ color: ColorModel)
    func refreshData()
}

class FavouriteViewModel {
    
    private var colourData: [ColorModel]? // Data from core data, not to mutate
    private var colours: [ColorModel]?
    
    let cellIdentifier = "ColorCellIdentifier"
    let navigationTitle = "Favourite colours"
    let nibName = "ColorCell"
    let placeholder = "Search hex or name"
    
    var searchPhrase: String?
    var delegate: FavouriteViewModelDelegate? = nil
    var sortingType: SortingType = .nameAscending
    
    var infoText: String {
        if colourData == nil || colourData?.isEmpty ?? true {
            return "Oh no!\nYou have no favorite colors yet!"
        } else {
            return "No colour for searching phrase!"
        }
    }
     
    var colorArrayIsEmpty: Bool {
        return colours?.isEmpty ?? true
    }
    
    var numberOfRows: Int {
        return colours?.count ?? 0
    } 
    
    func removeDataDelegate() {
        DataManager.shared.delegate = nil
    }
    
    func addDataDelegate() {
        DataManager.shared.delegate = self
    }
    
    func setSearchPhrase(_ phrase: String?) {
        searchPhrase = phrase
    }
    
    func filterColours() {
        guard let phrase = searchPhrase?.lowercased() else { return }
        colours = colourData?.filter({ $0.name.value.name.lowercased().contains(phrase) ||
                                        $0.hex.value.lowercased().contains(phrase) })
    }
    
    func reloadData() {
        if self.searchPhrase?.isEmpty ?? true {
            self.colours = self.colourData
        } else {
            self.filterColours()
        }
        sort()
        delegate?.refreshData()
    }
    
    func setSorting(_ sortingType: SortingType) {
        self.sortingType = sortingType
        reloadData()
    }
    
    func sort() {
        guard let colours = self.colours else { return }
        self.colours = sortingType.sort(objects: colours)
    }
    
    func refreshData() {
        DataManager.shared.getColorsList(completion: { data in
            self.colourData = data
            self.reloadData()
        })
    }
    
    func data(forIndex i: Int) -> (label1: String, label2: String, colour: UIColor)? {
        if i < colours?.count ?? 0, let model = colours?[i] {
            if sortingType == .hexAscending || sortingType == .hexDescending {
                return (model.hex.value, model.name.value.name, model.color)
            } else {
                return (model.name.value.name, model.hex.value, model.color)
            }
        } else {
            return nil
        }
    }
    
    func getColorModel(forIndex i: Int) {
        guard let model = colours?[i] else { return }
        delegate?.openColor(model)
    }
}

extension FavouriteViewModel: DataManagerDelegate {
    func dataHasChanged() {
        refreshData()
    }
}
