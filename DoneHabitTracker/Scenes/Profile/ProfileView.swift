//
//  ProfileView.swift
//  DoneHabitTracker
//
//  Created by Anyfantakis, Ioannis on 12/1/24.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel
    
    @State var selectedPill: PillTag? = nil
    
    
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
            VStack(spacing: 32) {
                HStack(spacing: 0) {
                    Text("profile_form_name")
                        .frame(width: 100, alignment: .leading)
                    
                    AppTextField("profile_form_name_hint", text: .constant(""))

                }
                HStack(spacing: 0) {
                    Text("profile_form_email".localized)
                        .frame(width: 100, alignment: .leading)
                    AppTextField("profile_form_email_hint", text: .constant(""))
                }
                HStack(alignment: .top, spacing: 0) {
                    Text("profile_form_password")
                        .frame(width: 100, alignment: .leading)
                    VStack(spacing: 16) {
                        AppTextField("profile_form_password_new", text: .constant(""))
                        
                        AppTextField("profile_form_password_repeat", text: .constant(""))
                    }
                }
                
                HStack(spacing: 64) {
                    Button(action: {
                        
                    }) {
                        Text("profile_btn_update")
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.btnEnabled)
                            .cornerRadius(5)
                    }
                    .disabled(false)
                    
                    Button(action: {
                        viewModel.logout()
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
    }
}

#Preview {
    ProfileView(appModel: ApplicationModel())
}
