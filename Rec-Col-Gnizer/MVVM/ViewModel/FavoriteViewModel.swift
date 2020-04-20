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
    private var dataModel: [(String, String)] = [] {
        didSet {
            self.delegate?.refreshData()
        }
    }
    
    var numberOfRows: Int {
        return dataModel.count
    } 
    
    func refreshData() {
        DataManager.shared.getColorsList(completion: { data in
            if let colorData = data {
                self.dataModel = colorData
            } else {
                self.dataModel.removeAll()
            }
        })
    }
    
    func data(forIndex i: Int) -> (name: String, hex: String)? {
        if i < dataModel.count {
            return dataModel[i]
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
