//
//  OnboardingView.swift
//  PastelOnBoarding
//
//  Created by Smit Kanojiya on 01/09/23.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel // ViewModel to manage onboarding data

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // Background gradient shape
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width * 0.65, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width * 0.35, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    path.closeSubpath()
                }
                .fill(viewModel.pageColors[viewModel.currentPageIndex])
            }
            .ignoresSafeArea()
            
            RectangleView() // A white rectangle view
            
            VStack {
                SkipButton {
                    viewModel.skipOnboarding()
                }
                
                OnboardingPagesView(viewModel: viewModel) // Display onboarding pages
                
                HStack {
                    CustomTabIndicator(pageCount: viewModel.onboardingPages.count, currentIndex: viewModel.currentPageIndex)
                    
                    Spacer()
                    
                    if viewModel.currentPageIndex > 0 {
                        PreviousPageButton(action: viewModel.goToPreviousPage)
                    }
                    
                    NextPageButton {
                        viewModel.goToNextPage()
                    }
                }
                .padding(EdgeInsets(top: 40, leading: 50, bottom: 30, trailing: 50))
            }
        }
    }
}

// OnboardingPageView is used to display individual onboarding pages
struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(page.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 450, alignment: .trailing)
            
            Text(page.title)
                .font(Font.custom("Asap", size: 22).weight(.semibold))
                .kerning(0.44)
                .lineSpacing(2.5)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 50, height: 3)
                .background(Color(red: 0.59, green: 0.72, blue: 0.68))
                .cornerRadius(2)
            
            Text(page.description)
                .font(Font.custom("Asap", size: 14))
                .kerning(0.28)
                .foregroundColor(.textColor)
                .lineSpacing(5)
        }
        .padding(.horizontal, 50)
    }
}

// RectangleView is a custom view for the white rectangle
struct RectangleView: View {
    var body: some View {
        Rectangle()
            .cornerRadius(radius: 100, corners: [.topRight])
            .cornerRadius(3)
            .frame(maxHeight: 350)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

// SkipButton is a button to skip onboarding
struct SkipButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Rectangle()
                .frame(width: 60, height: 25)
                .foregroundColor(.white)
                .cornerRadius(radius: 15, corners: [.topRight])
                .cornerRadius(3)
                .overlay {
                    Text("Skip")
                        .foregroundColor(.textColor)
                        .font(.custom("Asap", size: 12))
                        .kerning(0.6)
                }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 30)
        .buttonStyle(.plain)
    }
}

// OnboardingPagesView is used to display a collection of onboarding pages
struct OnboardingPagesView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        TabView(selection: $viewModel.currentPageIndex) {
            ForEach(viewModel.onboardingPages.indices, id: \.self) { index in
                OnboardingPageView(page: viewModel.onboardingPages[index])
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

// CustomTabIndicator displays page indicators
struct CustomTabIndicator: View {
    let pageCount: Int // Total number of onboarding pages
    let currentIndex: Int // Current selected page

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<pageCount) { index in
                if index == currentIndex {
                    // Selected page indicator
                    Circle()
                        .fill(.clear)
                        .frame(width: 15, height: 15)
                        .commonLinearGradient(colors: [.greenishGray, .oliveGreen])
                        .clipShape(Circle())
                        .shadow(color: .shadowColor, radius: 7.5, x: 0, y: 5)
                } else {
                    // Dots for other pages
                    Circle()
                        .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .frame(width: 15, height: 15)
                }
            }
        }
    }
}

// PreviousPageButton is a button to navigate to the previous page
struct PreviousPageButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image("back")
                .resizable()
                .frame(width: 50, height: 50)
        }
    }
}

// NextPageButton is a button to navigate to the next page
struct NextPageButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Rectangle()
                .fill(.clear)
                .frame(width: 50, height: 50)
                .commonLinearGradient(colors: [.greenishGray, .oliveGreen])
                .cornerRadius(10)
                .cornerRadius(radius: 25, corners: [.topRight])
                .shadow(color: .shadowColor, radius: 7.5, x: 0, y: 5)
                .overlay {
                    Image("Right")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
        }
    }
}

// CornerRadiusShape and CornerRadiusStyle are reused from your code
struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: OnboardingViewModel())
    }
}

