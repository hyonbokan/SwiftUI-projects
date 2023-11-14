//
//  SignInView.swift
//  PersonalBlog
//
//  Created by dnlab on 11/14/23.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = LogInViewViewModel()
    
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
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                OnboardButton (title: "Sign In", background: .purple) {
                    viewModel.login()
                }
                
                NavigationLink(destination: SignUpView()) {
                               Text("Create Account")
                                   .foregroundColor(.purple)
                                   .frame(maxWidth: .infinity) // Use maximum width to allow for center alignment
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: (Text("Can't log in. Please check if email and password are correct")))
            }
        }
    }
}

#Preview {
    SignInView()
}
