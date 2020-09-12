//
//  AdditionalTableViewController.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 11.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class AdditionalTableViewController: UITableViewController {
    
    @IBOutlet private weak var createButton: UIButton!
    @IBOutlet private weak var whenCollectAmountButton: UIButton! {
        didSet {
            whenCollectAmountButton.setImage(#imageLiteral(resourceName: "radio_on_24"), for: .selected)
        }
    }
    @IBOutlet private weak var dateButton: UIButton!
    @IBOutlet private weak var chooseDateButton: UIButton!
    @IBOutlet private weak var exactTimeButton: UIButton! {
        didSet {
            exactTimeButton.setImage(#imageLiteral(resourceName: "radio_on_24"), for: .selected)
            exactTimeButton.isSelected = true
        }
    }
    
    var titleText: String?
    var image: UIImage?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueID.postSegue.rawValue,
            let postingVC = segue.destination as? PostingViewController {
            postingVC.titleText = titleText
            postingVC.image = image
        }
    }
    
    @IBAction private func whenCollectAmountPressed() {
        whenCollectAmountButton.isSelected = true
        exactTimeButton.isSelected = false
        createButton.isEnabled = true
        title = "Оформление"
        chooseDateButton.setImage(UIImage(named: "Size Y_ Regular Default-1"), for: .normal)
        chooseDateButton.isEnabled = false
    }
    
    @IBAction private func exactTimePressed(_ sender: UIButton) {
        exactTimeButton.isSelected = true
        whenCollectAmountButton.isSelected = false
        createButton.isEnabled = false
        title = "Дополнительно"
        chooseDateButton.isEnabled = true
    }
    
    @IBAction private func chooseDatePressed() {
        dateButton.isHidden.toggle()
    }
    
    @IBAction private func datePressed() {
        chooseDateButton.setImage(UIImage(named: "Container-1"), for: .normal)
        dateButton.isHidden = true
        createButton.isEnabled = true
    }
}
