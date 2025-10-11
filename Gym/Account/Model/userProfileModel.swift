//
//  userProfileModel.swift
//  Gym
//
//  Created by shashwat singh on 11/10/25.
//

import Foundation
struct UserProfile: Codable {
    var fullName: String
    var gender: String
    var birthday: Date
    var phoneNumber: String
    var email: String
    var metroCardNumber: String
}
