//
//  ContentView.swift
//  SnacktacularUI
//
//  Created by Glen O'Connor on 14/4/2026.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    enum Field {
        case email, password
    }
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var buttonDisabled = true
    @State private var presentSheet: Bool = false
    @FocusState private var focusField: Field?
    
    var body: some View {

        
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
            
            Group {
                TextField("email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusField, equals: .email)
                    .onSubmit {
                        focusField = .password
                    }
                    .onChange(of: email) {
                        enableButton()
                    }
                
                ZStack {
                    SecureField("password", text: $password)
                        .submitLabel(.done)
                        .focused($focusField, equals: .password)
                        .onSubmit {
                            focusField = nil
                        }
                        .onChange(of: password) {
                            enableButton()
                        }
               }
                
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
                

            }
           
            
            HStack {
                Button("Sign Up") {
                    register()
                }
                .padding(.trailing)
                Button("Log In") {
                    login()
                }
                .padding(.leading)
            }
            .buttonStyle(.borderedProminent)
            .tint(.snack)
            .font(.title2)
            .padding(.top)
            .disabled(buttonDisabled)
            
        }
        .padding()
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .onAppear() {
            if Auth.auth().currentUser != nil {
                print("Log in successful")
                presentSheet = true
            }
            
        }
        .fullScreenCover(isPresented: $presentSheet) {
            ListView()
        }
    }
    
    func enableButton() {
        let emailIsGood = email.count >= 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        buttonDisabled = !(emailIsGood && passwordIsGood)
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result,
            error in
            if let error = error {
                print("😠 SIGNUP ERROR: \(error.localizedDescription)")
                alertMessage = "😠 SIGNUP ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("😎 Registration success!")
                presentSheet = true
//                alertMessage = "Regestered successfully! email: \(email) password: \(password)"
//                showingAlert = true
//                email = ""
//                password = ""
//                focusField = .email
//                showingAlert = true
                
                //TODO Load ListView
            }
        }
    }
    func login() {
        Auth.auth().signIn(withEmail: email, password:password) { result, error in
            if let error = error {
                print("😠 LOGIN ERROR: \(error.localizedDescription)")
                alertMessage = "🪵 LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else {
                print("🪵 LOGIN success!")
                //presentSheet = true
//                alertMessage = "Regestered successfully! email: \(email) password: \(password)"
//                showingAlert = true
                presentSheet = true
            }
        }
    }
}

#Preview {
    LoginView()
}
