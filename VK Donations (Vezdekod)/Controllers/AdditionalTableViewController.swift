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
    
    @IBAction private func whenCollectAmountPressed(_ sender: UIButton) {
        whenCollectAmountButton.isSelected = true
        exactTimeButton.isSelected = false
        createButton.isEnabled = true
        title = "Оформление"
    }
    
    @IBAction private func exactTimePressed(_ sender: UIButton) {
        exactTimeButton.isSelected = true
        whenCollectAmountButton.isSelected = false
        createButton.isEnabled = false
        title = "Дополнительно"
    }
}
