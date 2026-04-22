//
//  SpotDetailView.swift
//  SnacktacularUI
//
//  Created by Glen O'Connor on 22/4/2026.
//

import SwiftUI

struct SpotDetailView: View {
    @State var spot: Spot
    @State var spotVW = SpotViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Group {
                TextField("name", text: $spot.name)
                    .font(.title)
                
                TextField("address", text: $spot.address)
                    .font(.title2)
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.blue)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    let success = spotVW.saveSpot(spot: spot)
                    if success {
                        dismiss()
                    } else {
                        print("😭 Dang! Error saving spot!")
                    }
                }
                .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SpotDetailView(spot: Spot())
    }
}
