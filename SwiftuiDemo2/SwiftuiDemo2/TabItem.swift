//
//  TabItem.swift
//  SwiftuiDemo2
//
//  Created by HKinfoway Tech. on 08/05/26.
//


import SwiftUI

// MARK: - Model

struct TabItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
}

// MARK: - Main View

struct ContentView2: View {

    @Namespace private var animation
    @State private var selectedIndex: Int = 0

    private let tabs: [TabItem] = [
        .init(icon: "newspaper", title: "News"),
        .init(icon: "briefcase", title: "Work"),
        .init(icon: "calendar", title: "Calendar"),
        .init(icon: "message", title: "Chat"),
        .init(icon: "person.circle", title: "Profile")
    ]

    var body: some View {

        ZStack(alignment: .bottom) {

            // Background
            LinearGradient(
                colors: [
                    Color(red: 0.23, green: 0.25, blue: 0.90),
                    Color(red: 0.18, green: 0.20, blue: 0.80)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Decorative Blur Circles
            Group {
                Circle()
                    .fill(.white.opacity(0.05))
                    .frame(width: 260)

                Circle()
                    .fill(.white.opacity(0.04))
                    .frame(width: 180)
                    .offset(x: -140, y: -120)

                Circle()
                    .fill(.white.opacity(0.03))
                    .frame(width: 220)
                    .offset(x: 120, y: 180)
            }
            .blur(radius: 5)

            VStack(alignment: .leading, spacing: 12) {

                

                Spacer()
                    .frame(height: 10)

                Text("Tab bar animation")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundStyle(.white)

                Text("Quickly switch between different sections of an app with fluid tabs.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.white.opacity(0.7))
                    .frame(maxWidth: 300, alignment: .leading)

                Spacer()
            }
            .padding(.horizontal, 28)
            .padding(.top, 70)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

            // MARK: TAB BAR

            FloatingTabBar(
                tabs: tabs,
                selectedIndex: $selectedIndex,
                animation: animation
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 22)
        }
    }
}

// MARK: - Floating TabBar

struct FloatingTabBar: View {

    let tabs: [TabItem]

    @Binding var selectedIndex: Int

    var animation: Namespace.ID

    var body: some View {

        HStack(spacing: 0) {

            ForEach(Array(tabs.enumerated()), id: \.offset) { index, item in

                Button {

                    withAnimation(.interactiveSpring(
                        response: 0.45,
                        dampingFraction: 0.75,
                        blendDuration: 0.7
                    )) {
                        selectedIndex = index
                    }

                } label: {

                    VStack(spacing: 6) {

                        ZStack {

                            if selectedIndex == index {

                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                Color(red: 0.40, green: 0.35, blue: 1.0),
                                                Color(red: 0.32, green: 0.28, blue: 0.95)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 52, height: 52)
                                    .matchedGeometryEffect(
                                        id: "TAB",
                                        in: animation
                                    )
                                    .shadow(
                                        color: .blue.opacity(0.35),
                                        radius: 10,
                                        x: 0,
                                        y: 8
                                    )
                            }

                            Image(systemName: item.icon)
                                .font(
                                    .system(
                                        size: 20,
                                        weight: selectedIndex == index ? .bold : .medium
                                    )
                                )
                                .foregroundStyle(
                                    selectedIndex == index
                                    ? .white
                                    : Color(red: 0.35, green: 0.32, blue: 0.85)
                                )
                        }

                        if selectedIndex == index {

                            Text(item.title)
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(
                                    Color(red: 0.35, green: 0.32, blue: 0.85)
                                )
                                .transition(.opacity.combined(with: .scale))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 10)
        .padding(.bottom, 18)
        .background(
            RoundedRectangle(cornerRadius: 34)
                .fill(.white)
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 18,
            x: 0,
            y: 10
        )
    }
}

// MARK: - Preview

#Preview {
    ContentView2()
}
