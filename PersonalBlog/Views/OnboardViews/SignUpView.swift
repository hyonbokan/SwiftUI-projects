//
//  SingUpView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/14/23.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewViewModel()
    
    var body: some View {
        VStack {
            // Header
            VStack(alignment: .center) {
                Image("Personal_Blog")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                Text("Explore millions of personal stories!")
                    .font(.title3)
                    .bold()
            }
            .padding(.top, 60)
            Form {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage).foregroundStyle(.red)
                }
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                SecureField("Confirm Password", text: $viewModel.password2)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                OnboardButton (title: "Sign Up", background: .purple) {
                    viewModel.register()
                    UserDefaults.standard.set(viewModel.name, forKey: "username")
                    UserDefaults.standard.set(viewModel.email, forKey: "email")
                }
                .padding()
            }
        }
    }
}

//#Preview {
//    SignUpView()
//}
