//
//  SpotViewModel.swift
//  SnacktacularUI
//
//  Created by Glen O'Connor on 22/4/2026.
//

import Foundation
import FirebaseFirestore

@Observable
class SpotViewModel {
    
    
    func saveSpot(spot: Spot) -> Bool {
        let db = Firestore.firestore()
        
        if let id = spot.id {
            do {
                try db.collection("spots").document(id).setData(from: spot)
                print("👌 Data updated successfully!")
                return true
            } catch {
                print("😩Could not update data in 'spots' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
            try db.collection("spots").addDocument(from: spot)
            print("👌 Data added successfully!")
                return true
            } catch {
                print("😩Could not create a new spot in 'spots' \(error.localizedDescription)")
                return false
            }
        }
    }
}
