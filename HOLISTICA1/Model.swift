//
//  Model.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 2/11/23.
//

import Foundation

enum CourseType: String, Codable, Identifiable {
    case yoga, fuerzaEquilibrio, qiFlow, none
    
    var id:Self { self }
}

enum DifficultyTypes: String, Codable, Identifiable {
    case beginner, intermediate, advanced, expert, elite
    
    var id:Self { self }
}

enum YogaExperience: String, Codable, CaseIterable, Identifiable {
    case beginner = "beginner"
    case intermediate = "intermidiate"
    case advanced = "advanced"
    case expert = "expert"
    case master = "master"
    
    var id:Self { self }
    
}

enum YogaGoals: String, Codable, CaseIterable, Identifiable {
    case relaxation = "relaxation"
    case flexibility = "flexibility"
    case strength = "strength"
    case stressRelief = "stress relief"
    case mindfulness = "mindfulness"
    case fitness = "fitness"
    case spirituality = "spirituality"
    case rehabilitation = "rehabilitation"
    case weightLoss = "weight loss"
    case selfDiscovery = "self discovery"
    
    var id:Self { self }
}

enum Status: String, Codable, Identifiable {
    case unwatched, started, completed
    
    var id:Self { self }
}

struct UserInfo: Codable, Hashable {
    let name:String
    let email:String
    var profileCreated:Bool
}

struct Course: Codable, Hashable, Identifiable {
    let id:UUID
    let name:String
    let description:String
    let image:Data?
    let catchphrase: String
    let type:CourseType
    let icon:Data?
}

struct UserProfile: Codable, Hashable, Identifiable {
    let id:UUID
    let name:String
    let age:Int?
    let height:Int?
    let experience: YogaExperience
    let goal:YogaGoals
    let image:String?
}

struct CoursePrograms: Codable, Hashable, Identifiable {
    let id:UUID
    let name:String
    let description:String
    let difficulty:DifficultyTypes
    let image: Data?
    let programState:Status
    let courseID:UUID
    //let classes:[ProgramClasses]
}


struct ProgramClasses: Codable, Hashable, Identifiable {
    let id:UUID
    let name:String
    let description:String
    let class_status:Status
    //let videos:[ClassesVideos]
}

struct ClassesVideos: Codable, Hashable, Identifiable {
    let id:UUID
    let title:String
    let url:String
    let upload_date:Date
    let status:Status
}
