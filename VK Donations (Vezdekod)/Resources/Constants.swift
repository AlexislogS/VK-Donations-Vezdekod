//
//  Constants.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 11.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

enum SegueID: String {
    case regularDonation
    case additionalScreen
    case postSegue
}

enum Text {
    static let amountLabel = "Сумма в месяц, ₽"
    static let placeholder = "Сколько нужно в месяц?"
    static let regularDonationTitle = "Регулярный сбор"
}

enum AlertTitle {
    static let failedToGetImage = "Failed to get image"
    static let failedToFetchDonations = "Failed to fetch donations"
    static let pleaseTryAgain = "Failed to get image"
    static let wrongInput = "Wrong input"
    static let pleaseFill = "Please fill all fields"
}
