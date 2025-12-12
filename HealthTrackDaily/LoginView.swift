

import SwiftUI

struct LoginView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password
    }
    
    let onSwitchToRegister: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            // App title / logo
            VStack(spacing: 8) {
                Text("HealthTrack Daily")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Welcome back 👋")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            // Form
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .focused($focusedField, equals: .email)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .focused($focusedField, equals: .password)
                
                if let error = errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal)
            
            // Login button
            Button {
                handleLogin()
            } label: {
                Text("Log In")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            
            // Switch to register
            HStack {
                Text("Don’t have an account?")
                    .foregroundStyle(.secondary)
                Button(action: onSwitchToRegister) {
                    Text("Sign up")
                        .fontWeight(.semibold)
                }
            }
            .font(.footnote)
            
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
        .onTapGesture {
            focusedField = nil
        }
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func handleLogin() {
        errorMessage = nil
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return
        }
        
        // TODO: Replace with real authentication logic later.
        // For now we just log in if fields are not empty.
        isLoggedIn = true
    }
}
