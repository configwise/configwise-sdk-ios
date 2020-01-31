//
//  AppEnvironment.swift
//  ios-example
//
//  Created by Sergey Muravev on 23.12.2019.
//  Copyright © 2019 VipaHelda BV. All rights reserved.
//

import Combine
import SwiftUI
import Foundation
import ConfigWiseSDK

enum Navigation {
    case signIn
    case main
}

final class AppEnvironment: ObservableObject {
    
    @Published var navigation: Navigation = .signIn
    
    @Published var company: Loadable<CompanyEntity> = .notRequested
    
    @Published var catalog: Loadable<CatalogEntity> = .notRequested
    
    @Published var components: Loadable<[ComponentEntity]> = .notRequested
    
    var isLoading: Bool {
        company.isLoading || catalog.isLoading || components.isLoading
    }
    
    var mode: SdkVariant {
        .B2C
    }
    
    init() {
        // Let's initialize ConfigWiseSDK here
        ConfigWiseSDK.initialize([
            .variant: self.mode,
            .companyAuthToken: "YOUR_COMPANY_AUTH_TOKEN",
            .debugLogging: true,
            .debug3d: false
        ])

        self.navigation = .signIn

        // Auto sign-in
        self.company = .isLoading(last: self.company.value)
        AuthService.sharedInstance.currentCompany { company, error in
            if let error = error {
                self.company = .failed(error)
                return
            }
            if let company = company {
                self.company = .loaded(company)
                self.navigation = .main
                return
            }
            guard self.mode == .B2C else {
                self.company = .failed("Unauthorized - company not found.")
                return
            }

            // B2C mode - let's try to automatically sign-in in B2C mode
            self.signIn()
        }

        // Let's add observers
        initObservers()
    }
    
    deinit {
        // Remove observers
        NotificationCenter.default.removeObserver(self)
    }
    
    func signIn(email: String? = nil, password: String? = nil) {
        self.company = .isLoading(last: self.company.value)
        AuthService.sharedInstance.signIn(email: email, password: password) { user, error in
            if let error = error {
                self.company = .failed(error)
                self.navigation = .signIn
                return
            }
            guard user != nil else {
                self.company = .failed("Unauthorized - user not found.")
                self.navigation = .signIn
                return
            }
            
            AuthService.sharedInstance.currentCompany { company, error in
                if let error = error {
                    self.company = .failed(error)
                    self.navigation = .signIn
                    return
                }
                guard let company = company else {
                    self.company = .failed("Unauthorized - company not found.")
                    self.navigation = .signIn
                    return
                }
                
                self.company = .loaded(company)
                self.navigation = .main
            }
        }
    }
    
    func fetchComponents() {
        self.catalog = .isLoading(last: self.catalog.value)
        guard let company = self.company.value else {
            self.catalog = .notRequested
            self.components = .notRequested
            return
        }
        
        CatalogService.sharedInstance.obtainCatalogByCompany(company: company) { catalog, error in
            if let error = error {
                self.catalog = .failed(error)
                self.components = .failed(error)
                return
            }
            guard let catalog = catalog else {
                let error: Error = "No catalog yet. Please create it first."
                self.catalog = .failed(error)
                self.components = .failed(error)
                return
            }
            
            self.catalog = .loaded(catalog)
            
            self.components = .isLoading(last: self.components.value)
            ComponentService.sharedInstance.obtainAllComponentsByCatalog(catalog: catalog) { components, error in
                if let error = error {
                    self.components = .failed(error)
                    return
                }

                self.components = .loaded(components)
            }
        }
    }
}

extension AppEnvironment {
    
    private func initObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onUnsupportedAppVersion),
            name: ConfigWiseSDK.unsupportedAppVersionNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onSignOut),
            name: ConfigWiseSDK.signOutNotification,
            object: nil
        )
    }
    
    @objc func onUnsupportedAppVersion(notification: NSNotification) {
        // Publishing changes from background threads is not allowed (otherwise runtime crash issue occurs).
        // Make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
        DispatchQueue.main.async {
            self.company = .failed("Unsupported ConfigWiseSDK version. Please update it.")
            self.catalog = .notRequested
            self.components = .notRequested
            self.navigation = .signIn
        }
    }

    @objc func onSignOut(notification: NSNotification) {
        // Publishing changes from background threads is not allowed (otherwise runtime crash issue occurs).
        // Make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
        DispatchQueue.main.async {
            self.company = .notRequested
            self.catalog = .notRequested
            self.components = .notRequested
            self.navigation = .signIn
        }
    }
}
