//
//  ChooseSignView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct ChooseSignView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = OnboardingViewModel()
    @FocusState private var isFocusedNameField: Bool
    @State private var username: String = ""
    @State private var month: String?
    @State private var numberOfDay: String?

    var isEditMode: Bool = false
    var users: [User] = []

    var body: some View {
        VStack(spacing: 16) {
            OnboardingTitleView(title: "onboarding_choose_sign".localize)
                .opacity(isEditMode ? 0 : 1)
            
            Spacer()
            
            TextField(
                "",
                text: $username,
                prompt: Text("onboarding_name".localize)
                    .font(.montserrat(size: 14).weight(.medium))
                    .foregroundStyle(.gray)
            )
            .font(.montserrat(size: 14).weight(.medium))
            .textFieldStyle(BackgroundTextFieldStyle(backgroundColor: .actionButtonBackground))
            .focused($isFocusedNameField)
            .modifier(HeaderText("onboarding_what_is_your_name".localize))
            
            DropDownView(
                header: "onboarding_month".localize,
                hint: "onboarding_select".localize,
                options: viewModel.months,
                maxDisplayItems: 4,
                selection: $month
            )
            
            DropDownView(
                header: "onboarding_day".localize,
                hint: "onboarding_select".localize,
                options: viewModel.numberOfDaysInMonth,
                direction: .top,
                maxDisplayItems: 5,
                selection: $numberOfDay
            )
            .disabled(month == nil)
            
            Spacer()
            
            ActionButtonView(title: isEditMode ? "save".localize : "continue".localize) {
                if isEditMode {
                    didTapSaveUser()
                } else {
                    didTapContinue()
                }
            }
            .disabled(username.isEmpty || month == nil || numberOfDay == nil)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 26)
        .padding(.bottom, 16)
        .background(.backgroundPrimary)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .tint(Color(.actionButtonBackground))
                }
            }
        }
        .onTapGesture {
            isFocusedNameField = false
        }
        .onAppear {
            viewModel.fetchMonths()
            
            if isEditMode {
                guard let user = users.first else {
                    return
                }
                
                username = user.name
                month = user.month
                numberOfDay = user.numberOfBirthday
                
                viewModel.didSelect(monthName: user.month)
            }
        }
        .onChange(of: month) {
            guard let selectedMonth = month else {
                return
            }
            
            guard !isEditMode else {
                return
            }
            
            numberOfDay = nil
            viewModel.didSelect(monthName: selectedMonth)
        }
        .navigationDestination(item: $viewModel.sign) { (sign) in
            MainView(selectedSign: sign)
        }
    }
    
    private func didTapSaveUser() {
        guard let month else {
            return
        }
        guard let numberOfDay else {
            return
        }
        let sign = viewModel.fetchSign(numberOfDay: numberOfDay, monthName: month)
        let user = users.first
        
        user?.name = username
        user?.month = month
        user?.numberOfBirthday = numberOfDay
        user?.sign = sign
        
        dismiss()
    }
    
    private func didTapContinue() {
        guard let selectedMonth = month else {
            return
        }
        guard let selectedNumberOfDay = numberOfDay else {
            return
        }
        
        let sign = viewModel.fetchSign(numberOfDay: selectedNumberOfDay, monthName: selectedMonth)
        viewModel.sign = sign
        saveUser(name: username, sign: sign)
    }
    
    private func saveUser(name: String, sign: Sign) {
        guard let month else {
            return
        }
        guard let numberOfDay else {
            return
        }
        
        let user = User(
            name: name,
            month: month,
            numberOfBirthday: numberOfDay,
            sign: sign
        )
        modelContext.insert(user)
    }
}

#Preview {
    NavigationStack {
        ChooseSignView(isEditMode: true)
            .modelContainer(for: [User.self], inMemory: true)
    }
}
