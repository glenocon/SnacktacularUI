//
//  ListView.swift
//  SnacktacularUI
//
//  Created by Glen O'Connor on 14/4/2026.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct ListView: View {
    @FirestoreQuery(collectionPath: "spots") var spots: [Spot] // loads all the "spots" documents into the array varible named spots
    @State private var sheetIsPresented: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        NavigationStack {
            List(spots) { spot in
                NavigationLink {
                    SpotDetailView(spot: spot)
                } label: {
                    Text(spot.name)
                        .font(.title2)
                }
            }
 
            .listStyle(.plain)
            .navigationTitle("Snack Spopts:")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            print("🪵➡️ Log out successful!")
                            dismiss()
                        } catch {
                           
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack{
                    SpotDetailView(spot: Spot())
                }
            }
        }
    }
}

#Preview {
    ListView()
}
