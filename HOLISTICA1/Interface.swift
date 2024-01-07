//
//  File.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 18/10/23.
//

import Foundation

let AK:[UInt8] = [0x3B+0x30,0xBE-0x54,0x5B+0x18,0x45+0x29,0x42+0x22,0x22+0x44,0x38+0x34,0x83-0x22,0x60+0x0B,0x2A+0x3D,0xA8-0x42,0xB8-0x4A,0x87-0x26,0x18+0x1C,0x1E+0x57,0x63+0x11,0x49+0x1F,0x2F+0x0A,0x41-0x0E,0x02+0x36,0x45-0x11,0xC3-0x5B,0xB6-0x4D,0x9C-0x32,0x3C-0x09,0x46-0x12,0x45-0x0C,0x42-0x0E,0x44-0x11,0x65-0x2D,0xC8-0x60,0xC3-0x5A,0x0F+0x5B,0x82-0x1C,0x10+0x56,0x29+0x3D,0x5F+0x16,0x65+0x10,0x59-0x25,0x1B+0x19,0x61-0x2C,0xD8-0x63,0xAD-0x46,0x23+0x41,0xB2-0x4E]

let dev = URL(string: "http://localhost:8080/api")!
let pre = URL(string: "https://holistica-api-8b3ae2733f2c.herokuapp.com/api")!
extension URL {
    static let baseURL = pre
    static let createUsers = baseURL.appending(path: "createUser")
    static let createProfile = baseURL.appending(path: "profile/createProfile")
    static let validateUsr = baseURL.appending(path: "validateUser")
    static let siwaLogin = baseURL.appending(path: "SIWALogin")
    //static let registerDevice = baseURL.appending(path: "registerDevice")
    
    static let login = baseURL.appending(path: "loginJWT")
    static let getUserInfo = baseURL.appending(path: "getUserInfoJWT")
    static let getCourses = baseURL.appending(path: "course/getCourses")
    
    static let getBoughtPrograms = baseURL.appending(path: "program/getBoughtPrograms")
    
    static func unsuscribeProgram(program:UUID) -> URL {
        baseURL.appending(path: "program/unsuscribeProgram").appending(path: program.uuidString)
    }
    
    static func getProgramsByCourse(course:UUID) -> URL {
        baseURL.appending(path: "program/getProgramsByCourse").appending(path: course.uuidString)
    }
    
    static func getClassesByProgram(program:UUID) -> URL {
        baseURL.appending(path: "class/getClassesByProgram").appending(path: program.uuidString)
    }
    
    static func getVideoForClass(aClass:UUID) -> URL {
        baseURL.appending(path: "class/getClassesByProgram").appending(path: aClass.uuidString)
    }
    
    static func purchaseProgram(program:UUID) -> URL {
        baseURL.appending(path: "program/purchaseProgram").appending(path: program.uuidString)
    }
}
