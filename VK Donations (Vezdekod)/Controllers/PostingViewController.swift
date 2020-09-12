//
//  PostingViewController.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 12.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class PostingViewController: UIViewController {
    
    @IBOutlet weak var donationImageView: UIImageView!
    @IBOutlet weak var donationTitleLabel: UILabel!
    @IBOutlet weak var donationTextView: UITextView! {
        didSet {
            donationTextView.becomeFirstResponder()
        }
    }
    
    var titleText: String?
    var image: UIImage?
    private let storageManager = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donationTitleLabel.text = titleText
        donationImageView.image = image
    }
    
    @IBAction func postButtonPressed(_ sender: UIBarButtonItem) {
        storageManager.saveDonation(title: donationTitleLabel.text!, image: donationImageView.image!.pngData()!, description: donationTextView.text)
        presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
}
