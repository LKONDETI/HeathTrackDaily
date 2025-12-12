import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: View {
    @ObservedObject private var auth = AuthManager.shared
    @State private var showBiometricToggle = false
    @State private var biometricOn = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("HealthTrack Daily")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Sign in to save your data securely.")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Sign in with Apple button
            SignInWithAppleButton(
                .signIn,
                onRequest: configure,
                onCompletion: handle
            )
            .signInWithAppleButtonStyle(.black)
            .frame(height: 45)
            .cornerRadius(10)
            .padding(.horizontal)

            if showBiometricToggle {
                Toggle(isOn: $biometricOn) {
                    Text("Enable Face ID / Touch ID")
                }
                .padding(.horizontal)
                .onChange(of: biometricOn, initial: false) { newValue,<#arg#>  in
                    auth.enableBiometrics(newValue)
                }
            }

            Spacer()
        }
        .onAppear {
            // If there's already a stored user but biometrics is enabled,
            // we attempt to authenticate automatically in App launch flow.
            showBiometricToggle = true
            biometricOn = auth.isBiometricEnabled()
        }
    }

    // Request configuration for Apple sign-in (optional: request email, fullName)
    func configure(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }

    // Completion handler
    func handle(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResult):
            if let credential = authResult.credential as? ASAuthorizationAppleIDCredential {
                auth.handleAuthorization(credential: credential)
            } else {
                print("Unexpected credential type.")
            }
        case .failure(let error):
            print("Apple sign in failed: \(error.localizedDescription)")
        }
    }
}

