//
//  UserProfileViewModel.swift
//  Gym
//
//  Created by shashwat singh on 11/10/25.
//

import Foundation
class ProfileViewModel: ObservableObject {
    @Published var profile: UserProfile
    
    init() {
        self.profile = UserDefaultsManager.loadUserProfile() ??
            UserProfile(fullName: "Guest",
                        gender: "Male",
                        birthday: Date(),
                        phoneNumber: "",
                        email: "",
                        metroCardNumber: "")
    }
    
    func saveProfile() {
        UserDefaultsManager.saveUserProfile(profile)
    }
}
