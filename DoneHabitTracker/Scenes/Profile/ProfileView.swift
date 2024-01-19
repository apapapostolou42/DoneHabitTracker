//
//  ProfileView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel
    
    init(appModel: ApplicationModel) {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(appModel: appModel))
    }
    
    struct ProfileSection: View {
        
        @EnvironmentObject private var appModel: ApplicationModel
        @ObservedObject var viewModel: ProfileViewModel
        
        var body: some View {
            VStack(alignment: .leading ,spacing: 16) {
                HStack(alignment: .center, spacing: 32) {
                    // Profile Title
                    Text("profile_profile")
                        .font(.system(size: 44).bold())
                        .underline()
                    
                    // Profile Image
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 3.0)
                            .background(Color.clear)
                            .foregroundColor(.primary)
                            .frame(width: 44, height: 44)
                        
                        
                        Image("ti_profile")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                            .frame(width: 32, height: 32)
                    }
                    .tint(.primary)
                    
                    Spacer()
                }
                
                HStack(spacing: 0) {
                    Text("profile_form_name")
                        .frame(width: 100, alignment: .leading)
                    AppTextField(viewModel.usernNameHint, text: $viewModel.userName)
                        .textInputAutocapitalization(.never) // Disables auto-capitalization
                        .disableAutocorrection(true)         // Disables auto-correction
                        .foregroundColor(viewModel.isUserNameValid ? .primary : .red)

                }
                HStack(alignment: .center, spacing: 0) {
                    Text("profile_form_email".localized)
                        .frame(width: 100, alignment: .leading)
                    AppTextField(viewModel.emailHint, text: $viewModel.userEmail)
                        .textInputAutocapitalization(.never) // Disables auto-capitalization
                        .disableAutocorrection(true)         // Disables auto-correction
                        .foregroundColor(viewModel.isEmailValid ? .primary : .red)
                }
                Button(action: {
                    viewModel.updateProfile()
                }) {
                    Text("profile_btn_update")
                        .padding(8)
                        .foregroundColor(.white)
                        .background(viewModel.canUpdateUserInfo ? Color.btnEnabled : Color.btnDisabled)
                        .cornerRadius(5)
                }
                .disabled(!viewModel.canUpdateUserInfo)
            }
        }
    }
    
    struct SettingsSection: View {
        
        @EnvironmentObject private var appModel: ApplicationModel
        @ObservedObject var viewModel: ProfileViewModel
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("profile_settings")
                    .font(.system(size: 44).bold())
                    .underline()
                
                HStack(spacing: 0) {
                    Text("profile_settings_mode")
                        .frame(width: 100, alignment: .leading)
                    
                    AppDropDown(selectedItem: $appModel.selectedTheme, options: appModel.themes.map{$0.rawValue})
                }
                
                HStack(spacing: 0) {
                    Text("profile_settings_language")
                        .frame(width: 100, alignment: .leading)
                    
                    AppDropDown(selectedItem: $appModel.selectedLanguage, options: appModel.languages.map{$0.rawValue})
                }
                .padding(.bottom, 32)
            }
        }
    }
    
    struct ChangeEmailAndLogoutSection: View {
        
        @ObservedObject var viewModel: ProfileViewModel
        
        var body: some View {
            HStack(spacing: 0) {
                Button(action: {
                    viewModel.showChangeEmailConfirmationAlert = true
                }) {
                    Text("profile_request_password")
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.btnEnabled)
                        .cornerRadius(5)
                }
                .disabled(false)
                .alert(isPresented: $viewModel.showChangeEmailConfirmationAlert) {
                    Alert(
                        title: Text("profile_alert_changepassword_title"),
                        message: Text("profile_alert_changepassword_message"),
                        primaryButton: .default(Text("profile_alert_changepassword_yes")) {
                            viewModel.requestPasswordReset()
                        },
                        secondaryButton: .default(Text("profile_alert_changepassword_no")) {
                            
                        }
                    )
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.showLogoutConfirmationAlert = true
                }) {
                    Text("profile_btn_logout")
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.btnEnabled)
                        .cornerRadius(5)
                }
                .disabled(false)
                .alert(isPresented: $viewModel.showLogoutConfirmationAlert) {
                    Alert(
                        title: Text("profile_alert_logout_title"),
                        message: Text("profile_alert_logout_message"),
                        primaryButton: .default(Text("profile_alert_logout_yes")) {
                            viewModel.logout()
                        },
                        secondaryButton: .default(Text("profile_alert_logout_no")) {
                            
                        }
                    )
                }
            }
        }
    }
    
    struct AccountRemovelSection: View {
        
        @ObservedObject var viewModel: ProfileViewModel
        
        var body: some View {
            
            Button(action: {
                viewModel.showProfileDeletionConfirmationAlert = true
            }) {
                Text("profile_btn_delete")
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(5)
            }
            .alert(isPresented: $viewModel.showProfileDeletionConfirmationAlert) {
                Alert(
                    title: Text("profile_alert_delete_title"),
                    message: Text("profile_alert_delete_message"),
                    primaryButton: .default(Text("profile_alert_delete_yes")) {
                        Task {
                            await viewModel.wipeUserAccount()
                        }
                    },
                    secondaryButton: .default(Text("profile_alert_delete_no")) {}
                )
            }
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 48) {
                
                TabView {
                    Text("A")
                    
                    
                    Text("B")
                }
                
                ProfileSection(viewModel: viewModel)
                
                ChangeEmailAndLogoutSection(viewModel: viewModel)
                
                SettingsSection(viewModel: viewModel)
                
                AccountRemovelSection(viewModel: viewModel)
                
            }
        }
        .padding(.horizontal, 16)
        .onAppear {
            viewModel.refreshUserData()
        }
    }
}

#Preview {
    ProfileView(appModel: ApplicationModel())
        .environmentObject(ApplicationModel())
}
