
import SwiftUI

struct RegisterView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, email, password, confirmPassword
    }
    
    let onSwitchToLogin: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 40)
                
                // Title
                VStack(spacing: 8) {
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Start tracking your daily health 📊")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                // Form
                VStack(spacing: 16) {
                    TextField("Name", text: $name)
                        .textInputAutocapitalization(.words)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .focused($focusedField, equals: .name)
                    
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
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .focused($focusedField, equals: .confirmPassword)
                    
                    if let error = errorMessage {
                        Text(error)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal)
                
                // Sign up button
                Button {
                    handleRegister()
                } label: {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                .padding(.horizontal)
                
                // Switch to login
                HStack {
                    Text("Already have an account?")
                        .foregroundStyle(.secondary)
                    Button(action: onSwitchToLogin) {
                        Text("Log in")
                            .fontWeight(.semibold)
                    }
                }
                .font(.footnote)
                
                Spacer()
            }
        }
        .background(Color(.systemGroupedBackground))
        .onTapGesture {
            focusedField = nil
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func handleRegister() {
        errorMessage = nil
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Please fill out all fields."
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        
        // TODO: Replace with real registration logic later.
        // For now we just "create account" and log the user in.
        isLoggedIn = true
    }
}
