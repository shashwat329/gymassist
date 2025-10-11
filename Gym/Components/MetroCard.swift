//
//  MetroCard.swift
//  Gym
//
//  Created by shashwat singh on 11/10/25.
//

import SwiftUI

struct MetroCardView: View {
    @State private var showToast = false
    @State var cardNumber: String
    var issuedDate: String

    var themeGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color.green,Color.blue,Color.yellow
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    /// <#Description#>
    var body: some View {
        ZStack {
            themeGradient
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(radius: 4)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Card")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .tracking(2)
                        .rotationEffect(.degrees(-90))
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("NEXUSMED") // 🔹 Changed title
                            .font(.subheadline)
                        Text("एक कदम विकास की ओर")
                            .font(.subheadline)
                        Text("")
                            .font(.subheadline)
                    }
                    .foregroundStyle(.black)
                    .padding(.trailing, 10)
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CARD NO.")
                            .foregroundStyle(.black)
                            .font(.caption2)
                        
                        HStack {
                            Text(cardNumber.isEmpty ? "XXXXXXXXX" : cardNumber)
                            
                                .font(.headline)
                                .padding(6)
                                .background(.ultraThinMaterial, in: Capsule())
                            
                            Button {
                                UIPasteboard.general.string = cardNumber
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                withAnimation {
                                    showToast = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                    withAnimation {
                                        showToast = false
                                    }
                                }
                                
                            } label: {
                                Image(systemName: "doc.on.doc")
                                    .font(.subheadline)
                                    .padding(6)
                                    .background(.ultraThinMaterial, in: Capsule())
                                    .foregroundColor(.white)
                                
                            }
                        }
                    }
                    
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("ISSUED")
                            .foregroundStyle(.black)
                            .font(.subheadline)
                        //                                .padding(6)
                        //                                .background(.ultraThinMaterial, in: Capsule())
                        Text(issuedDate)
                            .font(.headline)
                            .padding(6)
                            .background(.ultraThinMaterial, in: Capsule())
                    }
                }
                .padding([.horizontal, .bottom], 16)
            }
            .padding(.top, 20)
            
            if showToast {
                VStack {
                    Spacer()
                    Text("Card number copied!") // 🔹 Updated toast message
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.black.opacity(0.75))
                        .cornerRadius(10)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.bottom, 20)
                }
                .animation(.easeInOut, value: showToast)
            }
        }
        .frame(height: 210)
        .onAppear {
            if let profile = UserDefaultsManager.loadUserProfile() {
                 print("inside metrocard: \(profile.metroCardNumber)")
                cardNumber = profile.metroCardNumber
            
            }
    }
    }
}

#Preview {
    MetroCardView(cardNumber: "426947937678", issuedDate: "11/2022")
}
