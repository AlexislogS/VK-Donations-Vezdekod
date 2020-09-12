//
//  NewDonationTableViewController.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 11.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class NewDonationTableViewController: UITableViewController {
    
    @IBOutlet private weak var donationImageView: UIImageView! {
        didSet {
            donationImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(uploadImage(recognizer:))))
        }
    }
    
    @IBOutlet private weak var clearImageButton: UIButton!
    
    @IBOutlet private weak var titleTextFiled: UITextField!
    @IBOutlet private weak var amountTextFiled: UITextField!
    @IBOutlet private weak var targetTextFiled: UITextField!
    @IBOutlet private weak var descriptionTextFiled: UITextField!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    var regularAmountLabelText: String?
    var regularAmountPlaceholderText: String?
    private var imageChanged = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let regularAmountLabelText = regularAmountLabelText {
            amountLabel.text = regularAmountLabelText
        }
        
        if let regularAmountPlaceholderText = regularAmountPlaceholderText {
            amountTextFiled.placeholder = regularAmountPlaceholderText
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueID.additionalScreen.rawValue,
            let additionalVC = segue.destination as? AdditionalTableViewController {
            additionalVC.titleText = titleTextFiled.text
            additionalVC.image = donationImageView.image
        } else if segue.identifier == SegueID.postSegue.rawValue,
            let postVC = segue.destination as? PostingViewController {
            postVC.titleText = titleTextFiled.text
            postVC.image = donationImageView.image
        }
    }
    
    @IBAction private func clearButtonPressed() {
        donationImageView.contentMode = .scaleAspectFit
        donationImageView.image = UIImage(named: "Cover")
        imageChanged = false
        clearImageButton.isHidden = true
    }
    
    @IBAction private func nextButtonPressed() {
        handleNextButton()
    }
    
    private func handleNextButton() {
        if titleTextFiled.hasText,
            amountTextFiled.hasText,
            targetTextFiled.hasText,
            descriptionTextFiled.hasText,
            imageChanged {
            if regularAmountLabelText == nil {
                performSegue(withIdentifier: SegueID.additionalScreen.rawValue, sender: nil)
            } else {
                performSegue(withIdentifier: SegueID.postSegue.rawValue, sender: nil)
            }
        } else {
            showAlert(with: AlertTitle.wrongInput, and: AlertTitle.pleaseFill)
        }
    }
    
    @objc private func uploadImage(recognizer: UITapGestureRecognizer) {
        guard recognizer.state == .recognized else { return }
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        camera.setValue(UIImage(systemName: "camera"), forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        let photo = UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.chooseImagePicker(source: .photoLibrary)
        })
        photo.setValue(UIImage(systemName: "photo"), forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        cancel.setValue(UIImage(systemName: "xmark"), forKey: "image")
        cancel.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        [camera, photo, cancel].forEach { actionSheet.addAction($0) }
        present(actionSheet, animated: true)
    }

}

    // MARK: - UITextFieldDelegate

extension NewDonationTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case titleTextFiled:
            amountTextFiled.becomeFirstResponder()
        case targetTextFiled:
            descriptionTextFiled.becomeFirstResponder()
        default:
            descriptionTextFiled.resignFirstResponder()
            handleNextButton()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == amountTextFiled,
            var text = textField.text {
            if text.contains("0") {
                text.insert(" ", at: text.firstIndex(of: "0")!)
            }
            if !text.contains("₽") {
                text.append(" ₽")
            }
            textField.text = text
        }
    }
}


    // MARK: - UIImagePickerControllerDelegate

extension NewDonationTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        } else {
            showAlert(with: AlertTitle.failedToGetImage,
                      and: AlertTitle.pleaseTryAgain)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage {
            donationImageView.contentMode = .scaleAspectFill
            donationImageView.image = image
            imageChanged = true
            clearImageButton.isHidden = false
        }
        picker.presentingViewController?.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.presentingViewController?.dismiss(animated: true)
    }
}
