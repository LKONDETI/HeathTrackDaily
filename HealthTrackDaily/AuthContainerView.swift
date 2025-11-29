//
//  AuthContainerView.swift
//  HealthTrackDaily
//
//  Created by Lakshmi Kondeti on 11/28/25.
//

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
