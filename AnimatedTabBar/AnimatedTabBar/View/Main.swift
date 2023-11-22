//
//  Main.swift
//  AnimatedTabBar
//
//  Created by Ilya Bondarenko on 22.11.2023.
//

import SwiftUI

struct Main: View {
    
    /// View Properties
    @State private var activeTab: Tab = .dashboard
    
    /// All tab's
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab in
        return .init(tab: tab)
    }
    
    /// Bounce Property
    @State private var bouncesDown: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.dashboard.title)
                }
                .setUpTab(.dashboard)
                
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.list.title)
                }
                .setUpTab(.list)
                
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.notifications.title)
                }
                .setUpTab(.notifications)
                
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.favorites.title)
                }
                .setUpTab(.favorites)
                
                NavigationStack {
                    VStack {
                        
                    }
                    .navigationTitle(Tab.settings.title)
                }
                .setUpTab(.settings)
            }
            
            Picker("", selection: $bouncesDown) {
                Text("Bounces Donw")
                    .tag(true)
                
                Text("Bounces Up")
                    .tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 15)
            .padding(.bottom, 20)
            
            CustomTabBar()
        }
    }
    
    /// Custom Tab Bar
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack(spacing: 0) {
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: tab.rawValue)
                        .font(.title2)
                        .symbolEffect(bouncesDown ? .bounce.down.byLayer : .bounce.up.byLayer, value: animatedTab.isAnimating)
                    
                    Text(tab.title)
                        .font(.caption2)
                        .textScale(.secondary)
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tab ? Color.primary : Color.gray.opacity(0.8))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.bouncy, completionCriteria: .logicallyComplete, {
                        activeTab = tab
                        animatedTab.isAnimating = true
                    }, completion: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            animatedTab.isAnimating = nil
                        }
                    })
                }
            }
        }
        .background(.bar)
    }
}

#Preview {
    Main()
}

extension View {
    @ViewBuilder
    func setUpTab(_ tab: Tab) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}

struct Previews_Main_LibraryContent: LibraryContentProvider {
    var views: [LibraryItem] {
        LibraryItem(/*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/)
    }
}
