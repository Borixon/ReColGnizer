//
//  ColorDataViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class ColorDataViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    var vm: ColorDataViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewComponents()
        setupTableView()
    }

    private func setupViewComponents() {
        view.backgroundColor = vm.color
        saveButton.tintColor = vm.color
        saveButton.layer.masksToBounds = true
        saveButton.layer.cornerRadius = Styles.applyButtonCornerRadius
        saveButton.backgroundColor = vm.contrastColor 
        navigationController?.navigationBar.tintColor = vm.contrastColor
        navigationController?.navigationBar.barTintColor = vm.color
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ColorNameCell", bundle: Bundle.main), forCellReuseIdentifier: vm.nameCellIndentifier)
        tableView.register(UINib(nibName: "ColumnDataCell", bundle: Bundle.main), forCellReuseIdentifier: vm.rgbCellIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    @IBAction func saveColor(_ sender: Any) {
        DataManager.shared.saveColor(vm.model)
    }
    
}

extension ColorDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0, let cell = tableView.dequeueReusableCell(withIdentifier: vm.nameCellIndentifier) as? ColorNameCell  {
            cell.setup(name: vm.nameData.name, hex: vm.nameData.hex, contrast: vm.contrastColor)
            return cell
            
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: vm.rgbCellIdentifier) as? ColumnDataCell  {
            if indexPath.row == 1 {
                cell.setup(data: vm.rgbData, contrast: vm.contrastColor)
                return cell
            } else {
                cell.setup(data: vm.cmykData, contrast: vm.contrastColor)
                return cell
            }
        }
        return UITableViewCell()
    }
}


