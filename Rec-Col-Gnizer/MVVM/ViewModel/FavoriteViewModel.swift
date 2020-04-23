//
//  FavoriteViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 19/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

protocol FavoriteViewModelDelegate {
    func openColor(_ color: ColorModel)
    func refreshData()
}

class FavoriteViewModel: NSObject {

    let cellIdentifier = "ColorCellIdentifier"
    public var delegate: FavoriteViewModelDelegate? = nil
    private var colorStrings: [(String, String)] = [] {
        didSet {
            colorStrings.sort(by: { $0.0 < $1.0 })
            self.delegate?.refreshData()
        }
    }
    
    var colorArrayIsEmpty: Bool {
        return colorStrings.isEmpty
    }
    
    var numberOfRows: Int {
        return colorStrings.count
    } 
    
    func removeDataDelegate() {
        DataManager.shared.delegate = nil
    }
    
    func addDataDelegate() {
        DataManager.shared.delegate = self
    }
    
    func refreshData() {
        DataManager.shared.getColorsList(completion: { data in
            if let colorData = data {
                self.colorStrings = colorData
            } else {
                self.colorStrings.removeAll()
            }
        })
    }
    
    func data(forIndex i: Int) -> (name: String, hex: String)? {
        if i < colorStrings.count {
            return colorStrings[i]
        } else {
            return nil
        }
    }
    
    func getColorModel(forIndex i: Int) {
        guard let hex = data(forIndex: i)?.hex else { return }
        DataManager.shared.getColor(hex: hex, completion: { model in
            if let colorModel = model {
                self.delegate?.openColor(colorModel)
            }
        })
    }
}

extension FavoriteViewModel: DataManagerDelegate {
    func dataHasChanged() {
        refreshData()
    }
}
