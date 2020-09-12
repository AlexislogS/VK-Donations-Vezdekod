//
//  NewsfeedTableViewController.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 12.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import UIKit

final class NewsfeedTableViewController: UITableViewController {
    
    // MARK: - Model
    
    private var donations = [Donation]()
    
    // MARK: - Manager
    
    private let storageManager = StorageManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 400
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    private func getData() {
        storageManager.fetchDonations { result in
            switch result {
            case .success(let donations):
                self.donations = donations
                tableView.reloadData()
            case .failure(let error):
                showAlert(with: AlertTitle.failedToFetchDonations, and: error.localizedDescription)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return donations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "donationCell", for: indexPath) as! DonationCell
        let donation = donations[indexPath.row]
        cell.configure(donation: donation)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let donation = donations[indexPath.row]
        storageManager.delete(donation: donation)
        donations.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
