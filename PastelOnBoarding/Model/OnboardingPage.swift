//
//  OnboardingPage.swift
//  PastelOnBoarding
//
//  Created by Smit Kanojiya on 01/09/23.
//

import Foundation

struct OnboardingPage: Identifiable {
    let id = UUID()
    let imageName: String // Image name for the onboarding page
    let title: String // Title of the onboarding page
    let description: String // Description of the onboarding page
}
