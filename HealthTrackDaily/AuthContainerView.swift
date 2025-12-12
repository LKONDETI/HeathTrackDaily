

import SwiftUI

struct AuthContainerView: View {
    @State private var showingLogin = true
    
    var body: some View {
        NavigationStack {
            if showingLogin {
                LoginView(onSwitchToRegister: {
                    showingLogin = false
                })
            } else {
                RegisterView(onSwitchToLogin: {
                    showingLogin = true
                })
            }
        }
    }
}
