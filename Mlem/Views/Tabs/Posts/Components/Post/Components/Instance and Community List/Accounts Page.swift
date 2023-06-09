//
//  Instance and Community List View.swift
//  Mlem
//
//  Created by David Bureš on 27.03.2022.
//

import SwiftUI

struct AccountsPage: View
{
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var accountsTracker: SavedAccountTracker

    @State private var isShowingInstanceAdditionSheet: Bool = false

    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                if !accountsTracker.savedAccounts.isEmpty
                {
                    List
                    {
                        ForEach(accountsTracker.savedAccounts)
                        { savedAccount in
                            NavigationLink
                            {
                                CommunityView(account: savedAccount, community: nil)
                                    .onAppear
                                    {
                                        appState.currentActiveAccount = savedAccount
                                    }
                            } label: {
                                HStack(alignment: .center)
                                {
                                    Text(savedAccount.username)
                                    Spacer()
                                    Text(savedAccount.instanceLink.host!)
                                        .foregroundColor(.secondary)
                                }
                                .minimumScaleFactor(0.01)
                                .lineLimit(1)
                            }
                        }
                        .onDelete(perform: deleteAccount)
                    }
                    .toolbar
                    {
                        ToolbarItem(placement: .navigationBarLeading)
                        {
                            EditButton()
                        }
                    }
                }
                else
                {
                    VStack(alignment: .center, spacing: 15)
                    {
                        Text("Add an account above to get started!")
                    }
                    .foregroundColor(.secondary)
                }
            }
            .onAppear
            {
                appState.currentActiveAccount = nil
            }
            .navigationTitle("Accounts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar
            {
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Button
                    {
                        isShowingInstanceAdditionSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingInstanceAdditionSheet)
            {
                AddSavedInstanceView(isShowingSheet: $isShowingInstanceAdditionSheet)
            }
        }
        .alert(appState.alertTitle, isPresented: $appState.isShowingAlert)
        {
            Button(role: .cancel)
            {
                appState.isShowingAlert.toggle()
            } label: {
                Text("Close")
            }

        } message: {
            Text(appState.alertMessage)
        }
        .onAppear
        {
            print("Saved thing from keychain: \(String(describing: AppConstants.keychain["test"]))")
        }
    }

    internal func deleteAccount(at offsets: IndexSet)
    {
        for index in offsets
        {
            let savedAccountToRemove: SavedAccount = accountsTracker.savedAccounts[index]

            accountsTracker.savedAccounts.remove(at: index)

            // MARK: - Purge the account information from the Keychain

            AppConstants.keychain["\(savedAccountToRemove.id)_accessToken"] = nil
        }
    }
}
