//
//  APIModel.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 21/10/23.
//

import Foundation

struct CreateUser: Codable {
    let name:String
    let email:String
    let password:String
    let newPassword:String
    let APIKey:String
    let dateCreated: String
}

struct TokenResponse: Codable {
    let token:String
}

struct APIKeyModel: Codable {
    let APIKey:String
}

struct CreateProfile: Codable {
    let name:String
    let age:Int?
    let height:Int?
    let experience: YogaExperience
    let goal:YogaGoals
    let image:String?
}

struct SIWARequest: Codable {
    let name:String
    let familyName:String
}

struct CertificateRequest: Codable {
    let deviceID:UUID
    let certificate:String
}
