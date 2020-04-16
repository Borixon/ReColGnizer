//
//  PickerViewController+TableView.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 16/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation
import UIKit

extension PickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: vm.sliderCellIdentifier) as? SliderCell {
            if let data: SliderData = vm.cellData(for: indexPath) {
                cell.setup(data: data)
                cell.delegate = self
                return cell
            }
        }
        fatalError("Unknown cell not implemented")
    }
}

extension PickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.rowHeight
        
    }
}
