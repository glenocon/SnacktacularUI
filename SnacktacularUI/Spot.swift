//
//  Spot.swift
//  SnacktacularUI
//
//  Created by Glen O'Connor on 22/4/2026.
//

import Foundation
import FirebaseFirestore

struct Spot: Identifiable, Codable {
    @DocumentID var id: String?
    var name = ""
    var address = ""
}
