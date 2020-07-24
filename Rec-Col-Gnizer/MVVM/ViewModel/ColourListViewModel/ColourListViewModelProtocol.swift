//
//  ColourListViewModelProtocol.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 13/07/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

protocol ColourListViewModelProtocol {
    
    var data: ColourListDataSourceProtocol! { get set }
    var cellIdentifier: String { get }
    var navigationTitle: String { get }
    var colorArrayIsEmpty: Bool { get }
    var placeholder: String { get }
    var infoText: String { get }
    var nibName: String { get }
    var numberOfItems: Int { get }
    var sortingType: SortingType { get set }
    
    func reloadData()
    func data(forIndex i: Int) -> (label1: String, label2: String, colour: UIColor)?
    func setSearchPhrase(_ phrase: String?)
    func getColorModel(forIndex i: Int, completion: @escaping (ColorModel?) -> ())
    func setSorting(_ sortingType: SortingType, completion: @escaping () -> ())
    func refreshData()
}
