//
//  ManualColorGetterViewController.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 10/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class SliderPickerViewController: BaseViewController {
 
    // @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkDataButton: UIButton!
    @IBOutlet weak var colorBackgroundView: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    let vm = SliderPickerViewModel()
    var searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        setupViewComponents()
        setupSegmentedControl()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutSubviews()
    }
    
    private func layoutSubviews() {
        tableView.layoutIfNeeded()
        colorBackgroundView.layoutIfNeeded()
        colorBackgroundView.layer.masksToBounds = true
        colorBackgroundView.layer.cornerRadius = Style.cornerRadiusBig
    }
    
    private func setupViewComponents() {
        vm.delegate = self
        vm.setController(self)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        colorBackgroundView.backgroundColor = vm.selectedColor
        checkDataButton.backgroundColor = .clear
        checkDataButton.tintColor = .clear
        checkDataButton.setTitleColor(.clear, for: .normal)
    }
    
    private func setupSearchBar() {
        searchBar.setShowsCancelButton(false, animated: false)
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        searchBar.placeholder = vm.placeholder
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = Style.keyColor
            searchBar.searchTextField.textColor = Style.keyContrastColor
            if let icon = searchBar.searchTextField.leftView as? UIImageView {
                let newImage = icon.image?.withTintColor(Style.accentKeyColor, renderingMode: .alwaysTemplate)
                searchBar.searchTextField.leftView = UIImageView(image: newImage)
            }
        } else if let _ = searchBar.value(forKey: "searchField") as? UITextField {
            // TODO:
        }

        searchBar.tintColor = Style.accentKeyColor
        searchBar.backgroundImage = UIImage()
        
        navigationItem.titleView = searchBar
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = vm.rowHeight
        tableView.register(UINib(nibName: "SliderCell", bundle: Bundle.main), forCellReuseIdentifier: vm.sliderCellIdentifier)
        tableView.allowsSelection = false
    }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        for i in 0...(vm.segmentedItems.count - 1) {
            segmentedControl.insertSegment(withTitle: vm.segmentedItems[i], at: i, animated: false)
        }
        segmentedControl.selectedSegmentIndex = vm.indexOfSelectedPicker
    }
    
    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        vm.segmentSelected(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func checkData(_ sender: Any) {
        openLoadingScreen()
        vm.sendDataRequest()
    }
    
    @objc internal func hideKeyboard() {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
    
    internal func revelKeyboard() {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

extension SliderPickerViewController: PickerViewModelDelegate {
    func show(color: ColorModel?, error: Error?) {
        hideLoadingScreen()
        if let color = color {
            coordinator?.openColorData(data: color)
        } else if let error = error {
            coordinator?.showError(error)
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func didPick(color: UIColor) {
        colorBackgroundView.backgroundColor = color
    }
}

extension SliderPickerViewController: SliderCellDelegate {
    func didChange(value: Float, type: SliderCellType) {
        vm.sliderDataChange(value, type: type)
    }
}


/* TODO Zbiorczy
 Alerty:
    bład kolorów,
    brak kamery,
    inne catche
 
 Kolejny etap
 Schematy kolorów
 ios12?
 Tutorial
 View o mnie
 Kamera naprawa pinch zoom
 Kamera dodanie flash
 Konwersja RGB-HLS-CMYK
 */

