//
//  PastelOnBoardingApp.swift
//  PastelOnBoarding
//
//  Created by Smit Kanojiya on 01/09/23.
//

import SwiftUI

@main
struct PastelOnBoardingApp: App {
    @StateObject var viewModel: OnboardingViewModel = OnboardingViewModel()
    var body: some Scene {
        WindowGroup {
            OnboardingView(viewModel: viewModel)
        }
    }
}
