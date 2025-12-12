import Foundation
import AuthenticationServices
import LocalAuthentication
import SwiftUI

final class AuthManager: NSObject, ObservableObject {
    static let shared = AuthManager()
    private override init() {}

    // MARK: - Published state the UI can observe
    @Published var isSignedIn: Bool = false
    @Published var displayName: String? = nil

    private let keychainService = "com.yourcompany.HealthTrackDaily"
    private let appleIdAccount = "appleUserId"
    private let biometricFlagAccount = "biometricEnabled"

    // MARK: - Public helpers

    func configureOnLaunch() {
        // Check if we have a saved Apple user identifier
        if let data = KeychainHelper.standard.read(service: keychainService, account: appleIdAccount),
           let userId = String(data: data, encoding: .utf8) {
            // Ask Apple for the credential state
            let provider = ASAuthorizationAppleIDProvider()
            provider.getCredentialState(forUserID: userId) { [weak self] state, _ in
                DispatchQueue.main.async {
                    switch state {
                    case .authorized:
                        // Optionally require biometrics if enabled
                        if self?.isBiometricEnabled() == true {
                            self?.authenticateWithBiometrics { success in
                                self?.isSignedIn = success
                            }
                        } else {
                            self?.isSignedIn = true
                        }
                    default:
                        // token revoked or not found
                        self?.signOutLocal()
                    }
                }
            }
        } else {
            isSignedIn = false
        }
    }

    // MARK: - Sign in with Apple flow (called from UI)
    func handleAuthorization(credential: ASAuthorizationAppleIDCredential) {
        // The important value to persist is user identifier
        let userId = credential.user
        KeychainHelper.standard.save(userId.data(using: .utf8)!, service: keychainService, account: appleIdAccount)

        // Save display name if available (only provided on first sign in)
        if let fullName = credential.fullName {
            // Build display name
            let name = [fullName.givenName, fullName.familyName].compactMap { $0 }.joined(separator: " ")
            displayName = name
        }

        // Mark signed in
        DispatchQueue.main.async {
            self.isSignedIn = true
        }
    }

    // MARK: - Sign out
    func signOut() {
        // remove keychain items and update state
        KeychainHelper.standard.delete(service: keychainService, account: appleIdAccount)
        KeychainHelper.standard.delete(service: keychainService, account: biometricFlagAccount)
        DispatchQueue.main.async {
            self.isSignedIn = false
            self.displayName = nil
        }
    }

    // If we don't want to revoke server tokens etc, keep this local sign out helper
    private func signOutLocal() {
        KeychainHelper.standard.delete(service: keychainService, account: appleIdAccount)
        DispatchQueue.main.async {
            self.isSignedIn = false
            self.displayName = nil
        }
    }

    // MARK: - Biometrics helpers

    func enableBiometrics(_ enabled: Bool) {
        let value = enabled ? "1" : "0"
        KeychainHelper.standard.save(value.data(using: .utf8)!, service: keychainService, account: biometricFlagAccount)
    }

    func isBiometricEnabled() -> Bool {
        guard let data = KeychainHelper.standard.read(service: keychainService, account: biometricFlagAccount),
              let str = String(data: data, encoding: .utf8) else {
            return false
        }
        return str == "1"
    }

    func authenticateWithBiometrics(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        var error: NSError?
        let reason = "Unlock HealthTrack Daily"

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                DispatchQueue.main.async {
                    completion(success)
                }
            }
        } else {
            // Biometrics not available, fallback to simple pass
            DispatchQueue.main.async { completion(false) }
        }
    }
}

