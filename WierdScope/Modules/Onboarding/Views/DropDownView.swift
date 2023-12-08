//
//  DropDownView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 07.12.2023.
//

import SwiftUI

struct DropDownView: View {
    enum Direction {
        case top
        case bottom
    }
    
    var header: String? = nil
    var hint: String
    var options: [String]
    var direction: Direction = .bottom
    var maxDisplayItems: Int = 6
    var cornerRadius: CGFloat = 12
    var backgroundColor: Color = .black
    var selectedColor: Color = .actionButtonBackground
    var unselectedColor: Color = .gray
    @Binding var selection: String?
    
    @Environment(\.isEnabled) private var isEnabled
    @State private var isShowOptions: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let header {
                Text(header)
                    .font(.montserrat(size: 12).weight(.bold))
                    .padding(.horizontal, 6)
                    .foregroundStyle(.gray)
            }
            
            GeometryReader { (proxy) in
                let size = proxy.size
                
                VStack(spacing: 0) {
                    if isShowOptions && direction == .top {
                        optionsView()
                    }
                    
                    HStack(spacing: 0) {
                        Text(selection ?? hint)
                            .font(.montserrat(size: 14).weight(.medium))
                            .foregroundStyle(selection == nil ? unselectedColor : selectedColor)
                            .lineLimit(1)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "chevron.down")
                            .font(.title3)
                            .foregroundStyle(.black)
                            .rotationEffect(.init(degrees: isShowOptions ? -180 : 0))
                    }
                    .padding(.horizontal, 16)
                    .frame(width: size.width, height: size.height)
                    .background(
                        backgroundColor
                    )
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            isShowOptions.toggle()
                        }
                    }
                    
                    if isShowOptions && direction == .bottom {
                        optionsView()
                    }
                }
                .clipped()
                .background(
                    backgroundColor,
                    in: .rect(cornerRadius: cornerRadius)
                )
                .frame(height: size.height, alignment: direction == .top ? .bottom : .top)
            }
            .frame(height: 50)
            .opacity(isEnabled ? 1.0 : 0.6)
        }
        .zIndex(isShowOptions ? 100 : 10)
    }
    
    @ViewBuilder
    private func optionsView(
        itemHeight: CGFloat = 40.0,
        spacing: CGFloat = 8.0
    ) -> some View {
        let scrollHeight = scrollAreaHeight(
            itemHeight: itemHeight,
            spacing: spacing,
            for: options.count > maxDisplayItems ? maxDisplayItems + 1 : options.count
        )
        
        ScrollView(.vertical) {
            VStack(spacing: spacing) {
                ForEach(options, id: \.self) { (option) in
                    HStack(spacing: 0) {
                        Text(option)
                            .lineLimit(1)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "checkmark")
                            .font(.caption)
                            .opacity(selection == option ? 1 : 0)
                    }
                    .foregroundStyle(selection == option ? selectedColor : unselectedColor)
                    .animation(.none, value: selection)
                    .frame(height: itemHeight)
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selection = selection == option ? nil : option
                            isShowOptions = false
                        }
                    }
                    
                    Divider()
                        .overlay(selectedColor)
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 16)
            .transition(.move(edge: direction == .top ? .bottom : .top))
        }
        .scrollDisabled(options.count < maxDisplayItems)
        .frame(height: scrollHeight)
    }
    
    private func scrollAreaHeight(
        itemHeight: CGFloat,
        spacing: CGFloat,
        for count: Int
    ) -> CGFloat {
        let spacingHeight = CGFloat(count - 1) * spacing
        let height = CGFloat(count) * itemHeight + spacingHeight
        return height
    }
}
#Preview {
    VStack(spacing: 16) {
        DropDownView(
            header: "Test 0",
            hint: "Selected",
            options: [
                "Option 1",
                "Option 2",
                "Option 3",
                "Option 4",
                "Option 5",
                "Option 6",
                "Option 7",
            ],
            selection: .constant("Option 1")
        )
        
        DropDownView(
            header: "test 2",
            hint: "Selected",
            options: [
                "Option 1",
                "Option 2",
                "Option 3",
            ],
            direction: .top,
            selection: .constant(nil)
        )
        
        DropDownView(
            header: "test 3",
            hint: "Selected",
            options: [
                "Option 1",
                "Option 2",
                "Option 3",
            ],
            direction: .top,
            selection: .constant(nil)
        )
        .disabled(true)
    }
    .background(Color(.backgroundPrimary))
}
