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
    
    struct ProfileHeader: View {
        struct ProfilePicPlaceholder: View {
            var body: some View {
                
                Button(action: { }) {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 3.0)
                            .background(Color.clear)
                            .foregroundColor(.primary)
                            .frame(width: 58, height: 58)
                        
                        
                        Image("ti_profile")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                            .frame(width: 44, height: 44)
                            
                        
                        Image("ti_plus")
                            .renderingMode(.template)
                            .foregroundColor(.primary)
                            .offset(CGSize(width: 30.0, height: 22.0))
                            .scaleEffect(1.2)
                    }
                    .tint(.primary)
                }
            }
        }
        
        var body: some View {
            HStack(alignment: .center, spacing: 32) {
                Text("profile_profile")
                    .font(.system(size: 58).bold())
                    .underline()
                
                ProfilePicPlaceholder()
                
                Spacer()
            }
        }
    }
    
    struct ProfileFields: View {
        
        @EnvironmentObject private var appModel: ApplicationModel
        @ObservedObject var viewModel: ProfileViewModel
        
        var body: some View {
            VStack(alignment: .leading ,spacing: 32) {
                HStack(spacing: 0) {
                    Text("profile_form_name")
                        .frame(width: 100, alignment: .leading)
                    
                    AppTextField("profile_form_name_hint", text: $viewModel.userName)

                }
                HStack(alignment: .center, spacing: 0) {
                    Text("profile_form_email".localized)
                        .frame(width: 100, alignment: .leading)
                    AppTextField("profile_form_email_hint", text: $viewModel.userEmail)
                        .foregroundColor(viewModel.isEmailValid ? .primary : .red)
                }
                HStack(alignment: .top, spacing: 0) {
                    Text("profile_form_password")
                        .frame(width: 100, alignment: .leading)
                    
                    Button(action: {
                        viewModel.requestPasswordReset()
                    }) {
                        Text("profile_request_password")
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.btnEnabled)
                            .cornerRadius(5)
                    }
                    .offset(CGSize(width: 0.0, height: -6.0))
                    .disabled(false)
                }
                .padding(.bottom, 16)
                
                HStack(spacing: 64) {
                    Button(action: {
                        viewModel.updateProfile()
                    }) {
                        Text("profile_btn_update")
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.btnEnabled)
                            .cornerRadius(5)
                    }
                    .disabled(false)
                    
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
                }
            }
        }
    }
    
    struct ProfileSettings: View {
        
        @EnvironmentObject private var appModel: ApplicationModel
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("profile_settings")
                    .font(.system(size: 58).bold())
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
            }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 48) {
                ProfileHeader()
                
                ProfileFields(viewModel: viewModel)
                
                ProfileSettings()
            }
        }
        .padding(16)
        .onAppear {
            viewModel.refreshUserData()
        }
        
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

#Preview {
    ProfileView(appModel: ApplicationModel())
}
