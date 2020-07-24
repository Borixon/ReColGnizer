//
//  ColourListDataSourceProtocol.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

protocol ColourListDataSourceProtocol {
    var data: ColourListDataComponents! { get set }
    var sortingType: SortingType { get set }
    var navigationTitle: String { get set }
    var searchPhrase: String? { get set }
    var numberOfItems: Int { get }
    var emptyList: Bool { get }
    
    func data(forIndex i: Int) -> ColorModel?
    func fetchList(_ colourSystem: ColourSystems?)
    func refreshData()
    func search(_ phrase: String?)
}

final class ColourListDataComponents {
    internal var colourData: [ColorModel]?
    
    init(colourData: [ColorModel]?) {
        self.colourData = colourData
    }
}
