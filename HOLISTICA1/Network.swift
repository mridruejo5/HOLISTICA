//
//  Network.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 22/10/23.
//

import SwiftUI
//import ACNetwork
import BCSecure2023
import MRNetwork

final class Network {
    static let shared = Network()
    
    var encoder:JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
    
    var decoder:JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    func createUser(user:CreateUser) async throws {
        try await MRNetwork.shared.postV(request: .post(url: .createUsers, data: user), statusOK: 201)
    }
    
    func validateUser(validation:ValidateUser) async throws {
        try await MRNetwork.shared.postV(request: .post(url: .validateUsr, data: validation))
    }
    
    func loginUser(user:String, password:String) async throws {
        guard let token = "\(user):\(password)".data(using: .utf8)?.base64EncodedString() else {
            throw NetworkError.unknown
        }
        let apikey = APIKeyModel(APIKey: Data(AK).base64EncodedString())
        let response = try await MRNetwork.shared.getJSONV(request:
                .post(url: .login, data: apikey, token: token, authMethod: .basic),
                                                           type: TokenResponse.self)
        guard let tokenData = response.token.data(using: .utf8) else {
            throw NetworkError.unknown
        }
        if SecManager.shared.isValidJWT(jwt: tokenData) {
            print("JWT VALID")
            SecKeyStore.shared.storeKey(key: tokenData, label: "TO")
        } else {
            // AQUI HABRIA QUE LANZAR UN ERROR QUE AVISARA DEL ERROR QUE HA HABIDO, CONTACTAR CON EL ADMIN, ETC. HACER ESTO AMPLIANDO EL NETWORK ERRORS DE LA LIBRERIA DE NETWORK CON ERRORES DE SEGURIDAD
            print("JWT not valid nor verified")
        }
    }
    
    private func getJSONToken<T:Codable>(url:URL, type:T.Type) async throws -> T {
        try await MRNetwork.shared.getJSONV(request: .get(url: url, token: SecManager.shared.getToken()), type: T.self, decoder: decoder)
    }
    
    private func postJSONToken<JSONSend:Codable, JSONReceive:Codable>
        (url:URL, type:JSONReceive.Type, data:JSONSend) async throws -> JSONReceive {
        try await MRNetwork.shared.getJSONV(request: .post(url: url, data: data, token: SecManager.shared.getToken(), encoder: encoder), type: type.self)
    }
    
    private func deleteJSONToken<JSONSend:Codable, JSONReceive:Codable>
        (url:URL, type:JSONReceive.Type, data:JSONSend) async throws -> JSONReceive {
        try await MRNetwork.shared.getJSONV(request: .delete(url: url, data: data, token: SecManager.shared.getToken(), encoder: encoder), type: type.self)
    }

    
    func userInfo() async throws -> UserInfo {
        try await getJSONToken(url: .getUserInfo, type: UserInfo.self)
    }
    
    func allCourses() async throws -> [Course] {
        try await getJSONToken(url: .getCourses, type: [Course].self)
    }
    
    func createProfile(profile:CreateProfile) async throws -> UserInfo {
        try await postJSONToken(url: .createProfile, type: UserInfo.self, data: profile)
    }
    
    func programsByCourse(course:UUID) async throws -> [CoursePrograms] {
        try await getJSONToken(url: .getProgramsByCourse(course: course), type: [CoursePrograms].self)
    }
    
    func purchaseProgram(program:UUID) async throws -> CoursePrograms {
        try await postJSONToken(url: .purchaseProgram(program: program), type: CoursePrograms.self, data: program)
    }
    
    func boughtPrograms() async throws -> [CoursePrograms] {
        try await getJSONToken(url: .getBoughtPrograms, type: [CoursePrograms].self)
    }
    
    func unsuscribe(program:UUID) async throws -> CoursePrograms {
        try await deleteJSONToken(url: .unsuscribeProgram(program: program), type: CoursePrograms.self, data: program)
    }
    
    func classesByProgram(program:UUID) async throws -> [ProgramClasses] {
        try await getJSONToken(url: .getClassesByProgram(program: program), type: [ProgramClasses].self)
    }
    
}
