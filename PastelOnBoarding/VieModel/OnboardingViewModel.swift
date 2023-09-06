//
//  OnboardingViewModel.swift
//  PastelOnBoarding
//
//  Created by Smit Kanojiya on 01/09/23.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    // Published properties to hold onboarding data
    @Published var onboardingPages: [OnboardingPage] = [
        OnboardingPage(imageName: "onboarding1",
                       title: "Welcome to our Delivery \nService!",
                       description: "Get your favorite items delivered right to your doorstep hassle-free."), // First onboarding page data
        OnboardingPage(imageName: "onboarding2",
                       title: "Track Your Delivery in \nReal-Time",
                       description: "Stay updated with the whereabouts of your package as it makes its way to you."), // Second onboarding page data
        OnboardingPage(imageName: "onboarding3",
                       title: "Enjoy Fast and Reliable \nDelivery",
                       description: "Experience quick and dependable delivery services that ensure your orders arrive promptly and in perfect condition."), // Third onboarding page data
    ]
    
    // Define colors for each onboarding page
    @Published var pageColors: [Color] = [.background.opacity(0.5), .background.opacity(0.75), .background]
    
    // Published properties to manage onboarding state
    @Published var currentPageIndex: Int = 0 // Currently selected onboarding page
    @Published var onboardingProgress: CGFloat = 0 // Progress indicator for onboarding
    
    // Function to update the progress indicator
    func updateOnboardingProgress() {
        withAnimation {
            onboardingProgress = CGFloat(currentPageIndex + 1) / CGFloat(onboardingPages.count)
        }
    }
    
    // Function to navigate to the next onboarding page
    func goToNextPage() {
        if currentPageIndex < onboardingPages.count - 1 {
            withAnimation {
                currentPageIndex += 1
            }
        }
    }
    
    // Function to navigate to the previous onboarding page
    func goToPreviousPage() {
        if currentPageIndex > 0 {
            withAnimation {
                currentPageIndex -= 1
            }
        }
    }
    
    // Function to skip the onboarding and proceed to the last page
    func skipOnboarding() {
        currentPageIndex = onboardingPages.count - 1
    }
}
