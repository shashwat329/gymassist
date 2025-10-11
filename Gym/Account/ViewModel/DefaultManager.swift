//
//  DefaultManager.swift
//  Gym
//
//  Created by shashwat singh on 11/10/25.
//

import Foundation
class UserDefaultsManager {
    private static let key = "UserProfileKey"
    
    static func saveUserProfile(_ profile: UserProfile) {
        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: key)
            print("saved successfully")
        }
    }
    
    static func loadUserProfile() -> UserProfile? {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(UserProfile.self, from: savedData) {
            return decoded
        }
        return nil
    }
}
