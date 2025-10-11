//
//  AccountView.swift
//  Gym
//
//  Created by shashwat singh on 11/10/25.
//

import SwiftUI

struct TransactionRow: View {
//    let themeColor = Color(hex: "1eacfa")
    var recipient: String = "Credited to NexusMed Card"
//    var note: String
    var amount: Double
    var time: String
    
    var body: some View {
        HStack {
            Image(systemName: "paperplane.fill")
                .foregroundColor(.white)
                .padding()
                .background(Color.theme)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("\(recipient)")
                    .font(.subheadline)
                    .bold()
    
                Text(time)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack(spacing: 0){
                Image(systemName: "indianrupeesign")
                Text("\(abs(amount), specifier: "%.2f")")
            }
            .foregroundColor(.green)
            .bold()
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}

// MARK: - Main Screen
struct AccountView: View {
    @State private var showProgress = false
    @StateObject var viewModel = ProfileViewModel()
    @State private var selectedTab = 1
    @AppStorage("issuedDate") var issuedDate: String = "09/2025";
    
    var body: some View {
        VStack(spacing: 20) {
            // Title
            HStack {
                Text("Welcome".uppercased())
                    .font(.title2)
                    .bold()
                Spacer()
                ProfileViewIcon()
            }
            .padding(.horizontal)
            
            // Card
            if let profile = UserDefaultsManager.loadUserProfile() {
                let _ = print("metrocard: \(profile.metroCardNumber)")
                MetroCardView(cardNumber: profile.metroCardNumber, issuedDate: issuedDate)
                    .padding(.horizontal)
            }
            else{
                MetroCardView(cardNumber: viewModel.profile.metroCardNumber, issuedDate: issuedDate)
                    .onAppear{
                        if let profile = UserDefaultsManager.loadUserProfile() {
                            print("Card:", profile.metroCardNumber)
                        } else {
                            print("No profile saved yet")
                        }
                        
                    }
                
                    .padding(.horizontal)
            }
            
            // History
            HStack{
                VStack(alignment: .leading) {
                    Text("History")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            if !true {
                                if showProgress {
                                    ProgressView("Loading...")
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .scaleEffect(1.5)
                                }
                                else {
                                    HStack{
                                        Spacer()
                                        
                                        Text("No transactions history Found")
                                            .font(.callout)
                                            .foregroundStyle(Color.red)
                                        Spacer()
                                    }
                                }
                                
                            }
                            else{
                                TransactionRow(amount: 1200, time: "02:20 PM")
                                TransactionRow(amount: 1200, time: "09:00 AM")
                                TransactionRow( amount: 1200, time: "02:20 PM")
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showProgress = false
                    }
                }
                Spacer()
            }
            Spacer()
        }
    }
}
struct ProfileViewIcon: View {
    var imageName: String = "person.crop.circle.fill"
    
    var body: some View {
        NavigationLink {
            ProfileView(viewModel: ProfileViewModel())
        } label: {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .foregroundColor(Color.primary)
        }

    }
}
