//
//  UserProfileView.swift
//  Gym
//
//  Created by shashwat singh on 11/10/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject  var viewModel  = ProfileViewModel()
    @State private var showEdit = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                VStack(spacing: 8) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray.opacity(0.6))
                        .padding(.bottom, 4)
                    
                    Text(viewModel.profile.fullName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(viewModel.profile.metroCardNumber)
                        .foregroundColor(Color.primary)
                        .font(.subheadline)
                    
                    Button(action: { showEdit.toggle() }) {
                        Text("Edit Profile")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.theme)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 50)
                    }
                    .padding(.top, 8)
                }
                .padding(.top, 30)
                
                // Options
                Spacer()
                bottombarView()
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showEdit) {
                EditProfileView(viewModel: viewModel)
            }
        }
    }
}

// MARK: - Row Component
struct ProfileRow: View {
    var icon: String
    var title: String
    var isDestructive: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color.primary)
                .frame(width: 24)
            Text(title)
                .font(.system(size: 16, weight: .medium))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Edit Profile Screen
struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Profile Pic + Name
            VStack(spacing: 6) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .foregroundColor(.gray.opacity(0.6))
                    .padding(.bottom, 4)
                
                Text(viewModel.profile.fullName)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(viewModel.profile.metroCardNumber)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
            .padding(.top, 20)
            VStack(spacing: 12) {
                CustomTextFieldView("Full name", text: $viewModel.profile.fullName)
                CustomTextFieldView("Gender", text: $viewModel.profile.gender)
                DatePicker("Birthday", selection: $viewModel.profile.birthday, displayedComponents: .date)
                     .datePickerStyle(.compact)
                     .padding()
                     .background(Color.gray.opacity(0.1))
                     .cornerRadius(10)
                CustomTextFieldView("Phone number", text: $viewModel.profile.phoneNumber)
                CustomTextFieldView("Email", text: $viewModel.profile.email)
                CustomTextFieldView("Metro Card Number", text: $viewModel.profile.metroCardNumber)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Save Button
            Button(action: {
                viewModel.saveProfile()
                dismiss()
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.theme)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Custom TextField Component
struct CustomTextFieldView: View {
    var placeholder: String
    @Binding var text: String
    
    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
    }
}

// MARK: - Preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(viewModel: <#ProfileViewModel#>viewModel: <#ProfileViewModel#>)
//    }
//}
