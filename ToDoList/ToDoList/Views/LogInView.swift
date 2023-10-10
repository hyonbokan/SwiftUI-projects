//
//  LogInView.swift
//  ToDoList
//
//  Created by dnlab on 2023/10/05.
//

import SwiftUI

struct LogInView: View {
    @StateObject var viewModel = LogInViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(
                    title: "To Do List",
                    subtitle: "Get things done!",
                    angle: 15,
                    background: .pink)
                
                // Login Form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TLButton(
                        title: "Log In",
                        background: .blue
                    ) {
                        // Attempt log in
                        viewModel.login()
                    }
                    .padding()
                }
                .offset(y: -50)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: (Text("Can't log in. Please check if email and password are correct.")))
                }
                
                // Create Account
                VStack {
                    Text("New user?")
                    NavigationLink("Create an Account", destination: RegisterView())
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
