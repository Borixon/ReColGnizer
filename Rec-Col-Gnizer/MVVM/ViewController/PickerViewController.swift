//
//  ManualColorGetterViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, Storyboarded {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var textFieldsStack: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var checkDataButton: UIView!
    
    var coordinator: MainCoordinator?
    let vm = PickerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        vm.delegate = self
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "#AA420C, Yellow..."
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = vm.rowHeight
        tableView.register(UINib(nibName: "SliderCell", bundle: Bundle.main), forCellReuseIdentifier: "TMEP")
    }
    
    @IBAction func checkData(_ sender: Any) {
        vm.getColor()
    }
    
    private func setupCategoryStack() {
        
    }
}

extension PickerViewController: PickerViewModelDelegate {
    func show(color: ColorModel) {
        coordinator?.openColorData(data: color)
    }
    
    func show(error: Error?) {
        coordinator?.show(error: error)
    }
}

extension PickerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TMEP")!
        return cell
    }
}

extension PickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vm.rowHeight
        
    }
}

extension PickerViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
}
