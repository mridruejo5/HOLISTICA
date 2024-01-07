//
//  SecManager.swift
//  HOLISTICA1
//
//  Created by Miguel Ridruejo on 21/10/23.
//

import Foundation
import BCSecure2023
import CryptoKit
import LocalAuthentication
import AuthenticationServices

enum UserState {
    case authorized, notAuthorized, unknown
}

final class SecManager {
    
    private let sk:[UInt8] = [0x8A-0x27,0x46+0x04,0x03+0x2E,0x21+0x2D,0x90-0x25,0x9D-0x48,0x06+0x54,0x81-0x0E,0x1A+0x40,0xC4-0x4D,0x86-0x10,0x49-0x1E,0x48+0x1B,0x45-0x0F,0x30+0x24,0xA7-0x3D,0x4C-0x14,0x0F+0x27,0x27+0x46,0x00+0x7A,0xAF-0x46,0x78-0x30,0x57-0x0D,0x67-0x1D,0xBD-0x57,0x5A-0x02,0x06+0x48,0xA8-0x3A,0x11+0x69,0x09+0x2A,0x28+0x28,0x30+0x36,0x00+0x31,0x96-0x2F,0x41+0x12,0x84-0x34,0x1C+0x34,0x25+0x3C,0x44+0x11,0x0E+0x37,0x9F-0x38,0x9C-0x2B,0x54-0x07,0x0E+0x2F]
    
    static let shared = SecManager()
    
    var getSK:SymmetricKey {
        get throws {
            guard let skString = String(data: Data(sk), encoding: .utf8),
                  let skData = Data(base64Encoded: skString) else {
                throw CryptoKitError.incorrectKeySize
            }
            return SymmetricKey(data: skData)
        }
    }
    
    //var keyAgreement:SymmetricKey!
    
    var biometry:LABiometryType = .none
    var isBiometryLogged = false
    
    var isCredentialOK:UserState = .unknown
    
    init() {
        let context = LAContext()
        var authError:NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            biometry = context.biometryType
        }
        SIWAInit()
        //cipherInit()
    }
    
    /*
    func cipherInit() {
        if SecKeyStore.shared.readKey(label: "PRIVATEKEY") == nil {
            let keyAgreement = P256.KeyAgreement.PrivateKey()
            let data = keyAgreement.rawRepresentation
            SecKeyStore.shared.storeKey(key: data, label: "PRIVATEKEY")
        }
        
        if SecKeyStore.shared.readKey(label: "DEVICEID") == nil {
            if let id = UUID().uuidString.data(using: .utf8) {
                SecKeyStore.shared.storeKey(key: id, label: "DEVICEID")
            }
        }
        
        Task {
            if let privateKey = SecKeyStore.shared.readKey(label: "PRIVATEKEY"),
               let idData = SecKeyStore.shared.readKey(label: "DEVICEID"),
               let idString = String(data: idData, encoding: .utf8),
               let id = UUID(uuidString: idString) {
                let key = try P256.KeyAgreement.PrivateKey(rawRepresentation: privateKey)
                let request = CertificateRequest(deviceID: id,
                                                 certificate: key.publicKey.rawRepresentation.base64EncodedString())
                try await Network.shared.registerDevice(request: request)
            }
        }
    }

    func getSymmetricKey(clientCert: String) throws {
        guard let clientCertData = Data(base64Encoded: clientCert),
              let keyPrivate = SecKeyStore.shared.readKey(label: "PRIVATEKEY") else { return }
        let APIKey = Data(AK)
        let publicKey = try P256.KeyAgreement.PublicKey(rawRepresentation: clientCertData)
        let keyAgreementPrivate = try P256.KeyAgreement.PrivateKey(rawRepresentation: keyPrivate)
        let sharedSecret = try keyAgreementPrivate.sharedSecretFromKeyAgreement(with: publicKey)
        let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(using: SHA256.self, salt: APIKey, sharedInfo: Data(), outputByteCount: 32)
        let symmetricData = Data(symmetricKey.withUnsafeBytes( { Array($0) }))
        //print(symmetricData.base64EncodedString())
        SecKeyStore.shared.storeKey(key: symmetricData, label: "SYMMETRICKEY")
    }
     */
    
    func SIWAInit() {
        let provider = ASAuthorizationAppleIDProvider()
        guard let appleIDUserData = SecKeyStore.shared.readKey(label: "APPLEIDUSER"),
              let appleIDUser = String(data: appleIDUserData, encoding: .utf8) else { return }
        provider.getCredentialState(forUserID: appleIDUser) { [self] state, error in
            guard error == nil else { return }
            switch state {
            case .authorized:
                isCredentialOK = .authorized
            default:
                isCredentialOK = .notAuthorized
            }
        }
    }
    
    
    func isUserLogged() -> Bool {
        SecKeyStore.shared.readKey(label: "TO") != nil
    }
    
    func getToken() -> String? {
        guard let tokenData = SecKeyStore.shared.readKey(label: "TO") else {
            return nil
        }
        return String(data: tokenData, encoding: .utf8)
    }
    
    private func base64Padding(encodedString:String) -> String {
        var encoded = encodedString.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
        let paddingCount = encodedString.count % 4
        for _ in 0..<paddingCount {
            encoded += "="
        }
        return encoded
    }
    
    func isValidJWT(jwt:Data) -> Bool {
        guard let jwtString = String(data: jwt, encoding: .utf8) else {
            return false
        }
        let jwtParts = jwtString.components(separatedBy: ".")
        let sign = Data(base64Encoded: base64Padding(encodedString: jwtParts[2]))!

        do {
            let symmetricKey = try getSK
            let verify = jwtParts[0] + "." + jwtParts[1]
            return HMAC<SHA256>.isValidAuthenticationCode(sign,
                                                          authenticating: verify.data(using: .utf8)!,
                                                          using: symmetricKey)
        } catch {
            return false
        }
    }
    
    func SIWACredentials(credential: ASAuthorizationCredential) {
        guard let credential = credential as? ASAuthorizationAppleIDCredential,
              let userData = credential.user.data(using: .utf8),
              let token = credential.identityToken else { return }
        SecKeyStore.shared.storeKey(key: userData, label: "APPLEIDUSER")
        let request = SIWARequest(name: credential.fullName?.givenName ?? "User",
                                  familyName: credential.fullName?.familyName ?? "Unknown")
        Task {
            try await Network.shared.sendSIWALogin(token: token, request: request)
            NotificationCenter.default.post(name: .loginSIWAOK, object: nil)
        }
    }
    
    func logout() {
        SecKeyStore.shared.deleteKey(label: "TO")
    }
}
