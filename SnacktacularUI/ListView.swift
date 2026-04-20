//
//  ListView.swift
//  SnacktacularUI
//
//  Created by Glen O'Connor on 14/4/2026.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var alertMessage: String = "Error could not logout"
    
    var body: some View {
        NavigationStack {
            List {
                Text("List Items Go Hear")
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
//                            .alert(alertMessage, isPresented: $showingAlert) {
//                                Button("OK", role: .cancel) { }
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                     //TODO:
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ListView()
}
