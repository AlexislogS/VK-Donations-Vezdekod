//
//  StorageManager.swift
//  VK Donations (Vezdekod)
//
//  Created by Alex Yatsenko on 12.09.2020.
//  Copyright © 2020 AlexislogS. All rights reserved.
//

import CoreData

final class StorageManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DonationDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Fetch donations
    
    func fetchDonations(completion: (_ result: Result<[Donation], Error>) -> Void) {
        do {
            let request: NSFetchRequest<Donation> = Donation.fetchRequest()
            let donations = try persistentContainer.viewContext.fetch(request)
            completion(.success(donations))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    // MARK: - Save donations
    
    func saveDonation(title: String, image: Data, description: String) {
        let donation = Donation(context: persistentContainer.viewContext)
        donation.title = title
        donation.image = image
        donation.decriptionText = description
        try? self.persistentContainer.viewContext.save()
    }
    
    // MARK: - Delete donations
    
    func delete(donation: Donation) {
        persistentContainer.viewContext.delete(donation)
        try? persistentContainer.viewContext.save()
    }
}
